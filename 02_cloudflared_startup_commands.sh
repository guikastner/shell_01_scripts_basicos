#!/bin/bash

containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare|cloudflared")

echo "-------------------------------------------------------------"
echo "        Comando de inicialização dos containers"
echo "-------------------------------------------------------------"

for c in $containers; do
    echo ""
    echo "Container: $c"
    echo "-------------------------------------------"
    docker inspect $c | grep -i '"Cmd"' -A2
done
