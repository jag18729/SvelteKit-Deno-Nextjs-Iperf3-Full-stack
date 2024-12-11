# Iperf3 Network Testing Dashboard

One-click setup for iperf3 network testing dashboard.

## Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/jag18729/SvelteKit-Deno-Nextjs-Iperf3-Full-stack.git
cd SvelteKit-Deno-Nextjs-Iperf3-Full-stack

# 2. Run the setup script
./setup.sh

# 3. Start the application
./start.sh
```

That's it! The application will be running at:
- Frontend: http://localhost:5173
- API: http://localhost:8000
- Admin: http://localhost:3000

## Requirements

- Docker and Docker Compose (everything else runs in containers)
- Port 5173, 8000, and 3000 available

## What's Included

- SvelteKit frontend with Tailwind CSS
- Deno backend API
- Next.js admin panel
- PostgreSQL database
- iperf3 server
- Automatic setup and configuration
- Data persistence
- Basic authentication

## Configuration

All configuration is in `config.env`. The default settings work out of the box, but you can modify:

```env
# Database settings
DB_HOST=localhost
DB_PORT=5432
DB_NAME=iperf3_logs

# iperf3 settings
IPERF3_PORT=5201

# Web ports
FRONTEND_PORT=5173
API_PORT=8000
ADMIN_PORT=3000
```

## Architecture

Everything runs in Docker containers:
- `frontend`: SvelteKit application
- `api`: Deno server
- `admin`: Next.js admin panel
- `db`: PostgreSQL database
- `iperf3`: iperf3 server

## Development

To run in development mode with hot reloading:
```bash
./dev.sh
```

## Production

For production deployment:
```bash
./deploy.sh
```

## Troubleshooting

View logs:
```bash
./logs.sh
```

Reset everything:
```bash
./reset.sh
```