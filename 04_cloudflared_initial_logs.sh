#!/bin/bash

containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare|cloudflared")

echo "-------------------------------------------------------------"
echo "          Logs iniciais dos containers Cloudflare"
echo "-------------------------------------------------------------"

for c in $containers; do
    echo ""
    echo "Container: $c"
    echo "-------------------------------------------"
    docker logs $c 2>&1 | head -n 40
done
