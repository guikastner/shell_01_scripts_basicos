#!/bin/bash

echo "-------------------------------------------------------------"
echo "   Uso de memória dos containers Cloudflare (cloudflared)   "
echo "-------------------------------------------------------------"
echo ""

# Lista containers cujo nome contenha "cloudflare" ou "cloudflared"
containers=$(docker ps --format "{{.ID}} {{.Names}}" | grep -Ei "cloudflare|cloudflared")

if [ -z "$containers" ]; then
    echo "Nenhum container Cloudflare encontrado."
    exit 0
fi

echo "Container                  Mem Usage / Limit     %"
echo "-------------------------------------------------------------"

while read -r line; do
    id=$(echo $line | awk '{print $1}')
    name=$(echo $line | awk '{print $2}')

    # Pega apenas o "MemUsage" do stats
    mem=$(docker stats --no-stream --format "{{.MemUsage}} {{.MemPerc}}" $id)

    # Só imprime se não vier vazio
    if [ ! -z "$mem" ]; then
        mem_usage=$(echo $mem | awk '{print $1" "$2" "$3}')
        mem_percent=$(echo $mem | awk '{print $4}')
        printf "%-25s %-20s %s\n" "$name" "$mem_usage" "$mem_percent"
    fi

done <<< "$containers"

echo "-------------------------------------------------------------"
