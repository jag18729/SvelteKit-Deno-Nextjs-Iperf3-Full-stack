#!/bin/bash

# Make script executable
chmod +x start.sh dev.sh deploy.sh logs.sh reset.sh

# Build and start Docker containers
docker-compose up -d --build

# Wait for services to be ready
echo "Waiting for services to start..."
sleep 10

echo "Setup complete! Run ./start.sh to launch the application."