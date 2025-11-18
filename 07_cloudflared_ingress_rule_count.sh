#!/bin/bash

containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare|cloudflared")

echo "-----------------------------------------------------"
echo "       Número de ingress rules por container"
echo "-----------------------------------------------------"

for c in $containers; do
    echo ""
    echo "Container: $c"
    docker logs $c 2>&1 | grep -i '"hostname"' | wc -l
done
