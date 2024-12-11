#!/bin/bash

# Reset everything
docker-compose down -v
rm -rf data/*
./setup.sh