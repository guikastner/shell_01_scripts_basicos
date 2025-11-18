#!/bin/bash

containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare")

echo "-----------------------------------------------------"
echo "       Número de serviços configurados no túnel"
echo "-----------------------------------------------------"

for c in $containers; do
    echo ""
    echo "Container: $c"
    echo "-------------------------------------------"

    docker logs $c 2>&1 \
        | grep -Eo '"service":' \
        | wc -l
done
