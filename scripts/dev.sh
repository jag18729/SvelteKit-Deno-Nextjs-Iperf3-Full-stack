#!/bin/bash

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "docker-compose not found. Please install Docker Compose."
    exit 1
fi

# Start development environment
echo "Starting development environment..."

# Build and start containers
docker-compose -f docker-compose.dev.yml up --build -d

# Follow logs
docker-compose -f docker-compose.dev.yml logs -f