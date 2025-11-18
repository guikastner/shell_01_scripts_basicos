#!/bin/bash

containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare|cloudflared")

echo "-------------------------------------------------------------"
echo "         Limites de memória dos containers"
echo "-------------------------------------------------------------"

for c in $containers; do
    echo ""
    echo "Container: $c"
    echo "-------------------------------------------"
    docker inspect $c | grep -i mem
done
