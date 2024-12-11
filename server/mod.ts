import { Application, Router } from 'https://deno.land/x/oak/mod.ts';
import { Pool } from 'https://deno.land/x/postgres/mod.ts';

const app = new Application();
const router = new Router();

// Database connection
const pool = new Pool({
  user: 'postgres',
  password: 'postgres',
  database: 'iperf3_logs',
  hostname: 'db',
  port: 5432,
}, 20);

// CORS middleware
app.use(async (ctx, next) => {
  ctx.response.headers.set('Access-Control-Allow-Origin', '*');
  ctx.response.headers.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  ctx.response.headers.set('Access-Control-Allow-Headers', 'Content-Type');
  await next();
});

// Routes
router.get('/', (ctx) => {
  ctx.response.body = 'Iperf3 API Server Running';
});

app.use(router.routes());
app.use(router.allowedMethods());

console.log('Server running on http://localhost:8000');
await app.listen({ port: 8000 });