#!/bin/bash
set -euo pipefail

mkdir -p /data

echo "Downloading OSM data from $OSRM_PBF_URL"
curl -L -o /data/region.osm.pbf "$OSRM_PBF_URL"

echo "Processing with $OSRM_PROFILE profile"
osrm-extract -p /opt/$OSRM_PROFILE.lua /data/region.osm.pbf
osrm-partition /data/region.osrm
osrm-customize /data/region.osrm

echo "Starting OSRM server"
osrm-routed --algorithm mld /data/region.osrm &
OSRM_PID=$!

# Wait for OSRM to be ready (listening on port 5000)
until curl -s "http://localhost:5000/route/v1/driving/13.388860,52.517037;13.397634,52.529407" > /dev/null; do
    echo "Waiting for OSRM to be ready..."
    sleep 1
done

echo "OSRM is ready!"
touch /tmp/osrm-ready

wait $OSRM_PID
