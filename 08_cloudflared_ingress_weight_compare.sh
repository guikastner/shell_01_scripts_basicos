#!/bin/bash

echo "-----------------------------------------------------"
echo "          Comparando peso das configurações"
echo "-----------------------------------------------------"

for c in $(docker ps --format "{{.Names}}" | grep -Ei "cloudflare|cloudflared"); do
    echo ""
    echo "Container: $c"
    docker logs $c 2>&1 | grep -i '"ingress"' -A20 | sed 's/","/\n/g' | wc -l
done
