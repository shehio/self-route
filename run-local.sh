#!/bin/bash
docker rm -f osrm-container 2>/dev/null || true

docker build -t osrm-routing-service .

docker run -d \
  -p 5001:5000 \
  --name osrm-container \
  osrm-routing-service

# Wait for the container to be healthy
echo "Waiting for OSRM service to be ready..."
while true; do
    if docker ps --filter "name=osrm-container" --filter "health=healthy" | grep -q "osrm-container"; then
        break
    fi
    echo "Still initializing..."
    sleep 5
done

echo "OSRM service is ready!"
