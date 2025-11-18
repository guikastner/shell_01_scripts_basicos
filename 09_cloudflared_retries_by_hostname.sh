#!/bin/bash

containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare")

echo "-----------------------------------------------------"
echo "    Reconexões por hostname (QUIC / fallback events)"
echo "-----------------------------------------------------"

for c in $containers; do
    echo ""
    echo "Container: $c"
    docker logs $c 2>&1 | \
        grep -Eo '"hostname":"[^"]+"' | \
        sort | uniq -c | sort -nr
done
