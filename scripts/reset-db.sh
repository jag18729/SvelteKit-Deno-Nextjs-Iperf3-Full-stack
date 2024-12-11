#!/bin/bash

echo "Warning: This will reset the database. All data will be lost!"
read -p "Are you sure you want to continue? (y/N) " response

if [[ "$response" =~ ^[Yy]$ ]]; then
    # Stop containers
    docker-compose down
    
    # Remove database volume
    docker volume rm sveltekit-deno-nextjs-iperf3-full-stack_postgres_data
    
    # Start containers
    docker-compose up -d db
    
    echo "Database reset complete!"
else
    echo "Operation cancelled."
fi