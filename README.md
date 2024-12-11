# Iperf3 Network Testing Dashboard

A full-stack application for scheduling, running, and analyzing network performance tests using iperf3.

## Quick Start

```bash
# 1. Clone & Enter Directory
git clone https://github.com/jag18729/SvelteKit-Deno-Nextjs-Iperf3-Full-stack.git
cd SvelteKit-Deno-Nextjs-Iperf3-Full-stack

# 2. Run Setup
./setup

# 3. Start Development
./dev
```

That's it! Your development environment is running at:
- 🌐 Dashboard: http://localhost:5173
- ⚙️ API: http://localhost:8000
- 📊 Admin: http://localhost:3000

## Features

- 🔑 User Authentication & Management
- 📅 Test Scheduling & Configuration
- 📊 Real-time Results & Visualization
- 🔄 Automated Test Execution
- 📱 Responsive Design

## Development

```bash
# Reset everything (caution: deletes data)
./reset

# View logs
./logs

# Add test data
./seed
```

## Project Structure

```
├── frontend/     # SvelteKit UI
├── server/       # Deno API
├── admin/        # Admin Dashboard
└── db/           # Database
```

## API Routes

```
/api/auth   - Authentication
/api/tests  - Test Management
/api/config - System Configuration
```

## Requirements

- Docker & Docker Compose
- That's it! Everything else runs in containers

## Troubleshooting

1. Port conflicts? Edit `.env`
2. Docker issues? Run `./reset`
3. Need help? Run `./help`

## License

MIT