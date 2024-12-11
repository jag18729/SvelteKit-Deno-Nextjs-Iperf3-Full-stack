import { Application, Router } from 'https://deno.land/x/oak/mod.ts';
import { Pool } from 'https://deno.land/x/postgres@v0.17.0/mod.ts';

// Database connection
const pool = new Pool({
  user: Deno.env.get('DB_USER') || 'postgres',
  password: Deno.env.get('DB_PASSWORD') || 'postgres',
  database: Deno.env.get('DB_NAME') || 'iperf3_logs',
  hostname: Deno.env.get('DB_HOST') || 'db',
  port: 5432,
}, 20);

// Router setup
const router = new Router();

// API Routes
router
  .get('/api/tests', async (ctx) => {
    const client = await pool.connect();
    try {
      const result = await client.queryObject('SELECT * FROM scheduled_tests ORDER BY scheduled_time DESC');
      ctx.response.body = result.rows;
    } finally {
      client.release();
    }
  })
  .post('/api/tests', async (ctx) => {
    const client = await pool.connect();
    try {
      const body = ctx.request.body();
      const value = await body.value;
      
      const result = await client.queryObject(
        'INSERT INTO scheduled_tests (server_ip, bandwidth, duration, scheduled_time, status) VALUES ($1, $2, $3, $4, $5) RETURNING *',
        [value.serverIP, value.bandwidth, value.duration, new Date(), 'scheduled']
      );
      
      // Start iperf3 test
      const testProcess = new Deno.Command('iperf3', {
        args: [
          '-c', value.serverIP,
          '-b', `${value.bandwidth}M`,
          '-t', value.duration.toString(),
          '-J'  // JSON output
        ]
      });
      
      const output = await testProcess.output();
      const testResult = new TextDecoder().decode(output.stdout);
      
      // Save test results
      await client.queryObject(
        'INSERT INTO test_results (test_id, bandwidth_achieved, jitter, packet_loss, test_time, raw_data) VALUES ($1, $2, $3, $4, $5, $6)',
        [result.rows[0].id, 0, 0, 0, new Date(), testResult]
      );
      
      ctx.response.body = result.rows[0];
    } finally {
      client.release();
    }
  })
  .get('/api/results/:id', async (ctx) => {
    const client = await pool.connect();
    try {
      const result = await client.queryObject(
        'SELECT * FROM test_results WHERE test_id = $1',
        [ctx.params.id]
      );
      ctx.response.body = result.rows[0];
    } finally {
      client.release();
    }
  });

// CORS middleware
const app = new Application();

app.use(async (ctx, next) => {
  ctx.response.headers.set('Access-Control-Allow-Origin', '*');
  ctx.response.headers.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  ctx.response.headers.set('Access-Control-Allow-Headers', 'Content-Type');
  await next();
});

app.use(router.routes());
app.use(router.allowedMethods());

console.log('Server running on http://localhost:8000');
await app.listen({ port: 8000 });