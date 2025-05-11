FROM ghcr.io/project-osrm/osrm-backend:latest

RUN apk update
RUN apk add bash
RUN apk add curl

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV OSRM_PBF_URL="http://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf" \
    OSRM_PROFILE="car"

EXPOSE 5000

HEALTHCHECK --interval=5s --timeout=3s --start-period=30s --retries=3 \
    CMD test -f /tmp/osrm-ready && curl -f "http://localhost:5000/route/v1/driving/-71.0589,42.3601;-71.0937,42.3601" || exit 1

ENTRYPOINT ["/entrypoint.sh"]
