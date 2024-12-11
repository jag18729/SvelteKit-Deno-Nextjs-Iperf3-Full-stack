#!/bin/bash

echo "Checking dependencies..."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check Node.js
if command_exists node; then
    NODE_VERSION=$(node --version)
    echo "✓ Node.js installed: $NODE_VERSION"
else
    echo "✗ Node.js not found"
    echo "Please install Node.js 18 or later from https://nodejs.org"
fi

# Check npm
if command_exists npm; then
    NPM_VERSION=$(npm --version)
    echo "✓ npm installed: $NPM_VERSION"
else
    echo "✗ npm not found"
fi

# Check Deno
if command_exists deno; then
    DENO_VERSION=$(deno --version | head -n 1)
    echo "✓ Deno installed: $DENO_VERSION"
else
    echo "✗ Deno not found"
    echo "Please install Deno from https://deno.land"
fi

# Check Docker
if command_exists docker; then
    DOCKER_VERSION=$(docker --version)
    echo "✓ Docker installed: $DOCKER_VERSION"
else
    echo "✗ Docker not found"
    echo "Please install Docker from https://docs.docker.com/get-docker/"
fi

# Check Docker Compose
if command_exists docker-compose; then
    COMPOSE_VERSION=$(docker-compose --version)
    echo "✓ Docker Compose installed: $COMPOSE_VERSION"
else
    echo "✗ Docker Compose not found"
fi

# Check PostgreSQL client
if command_exists psql; then
    PSQL_VERSION=$(psql --version)
    echo "✓ PostgreSQL client installed: $PSQL_VERSION"
else
    echo "✗ PostgreSQL client not found"
fi

echo "
For missing dependencies:
1. Node.js: https://nodejs.org
2. Deno: https://deno.land
3. Docker: https://docs.docker.com/get-docker/
4. PostgreSQL: https://www.postgresql.org/download/"