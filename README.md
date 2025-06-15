# Self-Route

This project sets up an OSRM (Open Source Routing Machine) routing service using Docker.

## Setup

1. Ensure Docker is installed on your system.
2. Clone this repository:
   ```sh
   git clone git@github.com:shehio/self-route.git
   cd self-route
   ```
3. Run the service:
   ```sh
   ./run.sh
   ```

## Usage

Once the service is running, you can access the OSRM routing service at:
```
http://localhost:5001/route/v1/driving/initial_point;final_point
```

## Notes

- The service automatically removes any existing container named `osrm-container` before starting a new one.
- The service runs on port 5001 to avoid conflicts with other services. 