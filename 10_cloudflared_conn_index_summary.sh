#!/bin/bash

containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare")

echo "-----------------------------------------------------"
echo "   Reconexões QUIC detectadas (connIndex por container)"
echo "-----------------------------------------------------"

for c in $containers; do
    echo ""
    echo "Container: $c"
    echo "-----------------------------------"

    # Conta quantas vezes cada connIndex aparece
    docker logs $c 2>&1 \
        | grep -Eo 'connIndex=[0-9]+' \
        | sed 's/connIndex=//' \
        | sort -n \
        | uniq -c \
        | head -n 30

done
