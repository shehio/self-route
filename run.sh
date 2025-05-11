#!/bin/bash

docker build -t osrm-routing-service .

docker run -d \
  -p 5000:5000 \
  --name osrm-container \
  osrm-routing-service

# Wait for the container to be healthy
echo "Waiting for OSRM service to be ready..."
while [ "$(docker inspect -f {{.State.Health.Status}} osrm-container)" != "healthy" ]; do
    echo "Still initializing..."
    sleep 5
done

echo "OSRM service is ready!"
