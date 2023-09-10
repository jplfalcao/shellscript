#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Apresenta o relatório de um host GNU/Linux
# Data de criação: 28/10/2021
# Data de modificação: 10/09/2023
# Versão: 1.7
# Uso: ./relatorio-maquina.sh

# Script testado em servidores Debian e CentOS

# Coletando informações sobre o sistema
kernel=$(uname -r)
system=$(hostnamectl | grep 'System' | tr -d ' ' | cut -d':' -f2)
cpuinfo=$(grep -c "model name" /proc/cpuinfo)
cpumodel=$(grep "model name" /proc/cpuinfo | head -n1 | cut -c14-)
memtotal=$(free -h | awk '/^Mem.?:/ {print $2}')
filesys=$(df -hT | grep -Ev '(tmpfs|udev|loop)')
uptime=$(uptime -s)
proc=$(ps aux --no-headers | wc -l)
endip=$(ip -o -4 a s | awk '/(eth|enp|ens|wl[ax]).*/ {print $4}')

clear

# Exibindo as informações formatadas
echo -e "==================================================================
Relatório da máquina: $HOSTNAME
Usuário logado: $USER
Data/Hora: $(date "+%Y-%m-%d %H:%M")
Endereço IP: $endip
==================================================================
\nMáquina ativa desde: $uptime
\nSistema operacional: $system
Versão do Kernel: $kernel
\nCPUs:
Quantidade de CPUs/Core: $cpuinfo
Modelo da CPU: $cpumodel
\nMemória total: $memtotal
\nPartições:
$filesys
\nTotal de processos em execução: $proc
=================================================================="

