#!/bin/bash

# Create project structure
echo "Creating project directory structure..."

# Frontend (SvelteKit)
mkdir -p frontend/src/routes
mkdir -p frontend/src/lib/components
mkdir -p frontend/src/lib/stores
mkdir -p frontend/static

# Backend (Deno)
mkdir -p server/routes
mkdir -p server/middleware
mkdir -p server/utils
mkdir -p server/db

# Admin (Next.js)
mkdir -p admin/pages
mkdir -p admin/components
mkdir -p admin/styles
mkdir -p admin/public

# Database
mkdir -p db/migrations
mkdir -p db/data

# Make scripts executable
chmod +x scripts/*.sh
chmod +x *.sh

echo "Directory structure created successfully!"

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
fi

# Create environment files
echo "Creating environment files..."
cat > .env << EOL
# Database settings
DB_HOST=localhost
DB_PORT=5432
DB_NAME=iperf3_logs
DB_USER=postgres
DB_PASSWORD=postgres

# Server settings
API_PORT=8000
FRONTEND_PORT=5173
ADMIN_PORT=3000

# JWT settings
JWT_SECRET=your-secret-key
EOL

# Copy environment file for development
cp .env .env.development

echo "Environment files created successfully!"

echo "Project initialized successfully!"