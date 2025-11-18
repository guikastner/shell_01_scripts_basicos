#!/bin/bash

echo "==============================================================="
echo "            RELATÓRIO COMPLETO CLOUDFARE / CLOUDFLARED"
echo "==============================================================="
echo ""

###################################
# 1. Memória
###################################
echo ""
echo ">>> Uso de memória"
echo "---------------------------------------------------------------"
/DATA/AppData/git/shell_01_scripts_basicos/01_cloudflared_mem_usage.sh

###################################
# 2. Comandos
###################################
echo ""
echo ">>> Comandos de inicialização"
echo "---------------------------------------------------------------"
containers=$(docker ps --format "{{.Names}}" | grep -Ei "cloudflare|cloudflared")
for c in $containers; do
    echo ""
    echo "Container: $c"
    docker inspect $c | grep -i '"Cmd"' -A2
done

###################################
# 3. Limites de memória
###################################
echo ""
echo ">>> Limites de memória"
echo "---------------------------------------------------------------"
for c in $containers; do
    echo ""
    echo "Container: $c"
    docker inspect $c | grep -i mem
done

###################################
# 4. Logs iniciais
###################################
echo ""
echo ">>> Logs iniciais"
echo "---------------------------------------------------------------"
for c in $containers; do
    echo ""
    echo "Container: $c"
    docker logs $c 2>&1 | head -n 20
done

echo ""
echo "==============================================================="
echo "Relatório concluído."
echo "==============================================================="
