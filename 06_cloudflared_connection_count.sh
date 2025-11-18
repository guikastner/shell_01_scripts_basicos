#!/bin/bash

containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare|cloudflared")

echo "-----------------------------------------------------"
echo "      Conexões QUIC / HTTP2 por container"
echo "-----------------------------------------------------"

for c in $containers; do
    echo ""
    echo "Container: $c"
    docker logs $c 2>&1 | grep -i "Registered tunnel connection" | wc -l
done
