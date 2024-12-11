# Iperf3 Network Testing Dashboard

A full-stack application for scheduling, running, and analyzing iperf3 network performance tests using SvelteKit, Deno, Next.js, and PostgreSQL.

## Prerequisites

- Node.js 18+ (for SvelteKit and Next.js)
- Deno 1.37+ (for backend API)
- PostgreSQL 15+ (in Azure VM)
- iperf3 installed on test machines

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/jag18729/SvelteKit-Deno-Nextjs-Iperf3-Full-stack.git
cd SvelteKit-Deno-Nextjs-Iperf3-Full-stack
```

2. Install frontend dependencies:
```bash
npm install
```

3. Set up environment variables:
Create a `.env` file in the root directory:
```env
DATABASE_URL=postgresql://username:password@your-azure-vm-ip:5432/iperf3_logs
IPERF3_SERVER=your-iperf3-server-ip
PORT=3000
```

4. Initialize the database:
```bash
psql -h your-azure-vm-ip -U your-username -d postgres -f db/init.sql
```

5. Start all services:
```bash
# Terminal 1: Start SvelteKit frontend
npm run dev

# Terminal 2: Start Deno backend
deno run --allow-net --allow-read --allow-env server/mod.ts

# Terminal 3: Start Next.js server (for SSR)
npm run dev:next
```

## Project Structure

```
├── src/                  # SvelteKit frontend
│   ├── routes/          # Frontend routes
│   ├── lib/             # Shared utilities
│   └── components/      # Reusable components
├── server/              # Deno backend
│   ├── mod.ts          # Main server file
│   ├── routes/         # API routes
│   └── db/             # Database utilities
├── next/                # Next.js SSR
│   ├── pages/          # Next.js pages
│   └── api/            # API routes
└── db/                  # Database migrations
```

## Database Setup

1. Connect to your Azure PostgreSQL VM:
```bash
psql -h your-azure-vm-ip -U your-username -d postgres
```

2. Create the database and tables:
```sql
CREATE DATABASE iperf3_logs;
\c iperf3_logs

CREATE TABLE scheduled_tests (
    id SERIAL PRIMARY KEY,
    server_ip VARCHAR(255),
    bandwidth INTEGER,
    duration INTEGER,
    scheduled_time TIMESTAMP,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE test_results (
    id SERIAL PRIMARY KEY,
    test_id INTEGER REFERENCES scheduled_tests(id),
    bandwidth_achieved FLOAT,
    jitter FLOAT,
    packet_loss FLOAT,
    test_time TIMESTAMP,
    raw_data JSONB
);
```

## Features

- Schedule iperf3 tests with custom parameters
- View real-time test results
- Historical test data visualization
- Export results in various formats
- REST API for test management

## API Endpoints

### Deno Backend (localhost:8000)
- `POST /api/tests` - Schedule a new test
- `GET /api/tests` - List all tests
- `GET /api/tests/:id` - Get test details
- `GET /api/results/:id` - Get test results

### Next.js SSR (localhost:3000)
- `/api/history` - Get test history
- `/api/analytics` - Get performance analytics

## Development

1. Run in development mode:
```bash
npm run dev         # SvelteKit frontend
npm run dev:next   # Next.js SSR
deno task start    # Deno backend
```

2. Build for production:
```bash
npm run build      # Build frontend
npm run build:next # Build Next.js
```

## Testing iperf3

1. Start iperf3 server:
```bash
iperf3 -s
```

2. Run test from client:
```bash
iperf3 -c server-ip -p 5201 -t 30
```

## Troubleshooting

### Common Issues

1. Database Connection:
- Check Azure VM firewall rules
- Verify PostgreSQL is running
- Test connection: `pg_isready -h your-azure-vm-ip`

2. iperf3 Server:
- Check if server is running: `netstat -an | grep 5201`
- Test connectivity: `telnet server-ip 5201`

3. Frontend Issues:
- Clear browser cache
- Check console for errors
- Verify API endpoints

## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## License

MIT

## Contact

For support: [Your Contact Information]