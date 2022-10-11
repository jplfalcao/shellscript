#!/usr/bin/env bash
# Autor: João Falcão
# Github: https://github.com/jplberserk
# Data de criação: 28/10/2021  
# Data de modificação: 04/10/2022  
# Versão: 1.5
# Uso: ./relatorio-maquina.sh

# Apresenta o relatório de um host GNU/Linux.

kernel=$(uname -r)
hostname=$(hostnamectl | grep 'hostname' | tr -d ' ' |  cut -d':' -f2)
system=$(hostnamectl | grep -i 'System' | tr -d ' ' | cut -d':' -f2)
cpuinfo=$(grep "model name" /proc/cpuinfo | wc -l)
cpumodel=$(grep "model name" /proc/cpuinfo | head -n1 | cut -c14-) 
memtotal=$(free -h | grep "Mem" | tr -d ' ' | cut -c6-9)
filesys=$(df -h | grep -Ev '(tmpfs|udev|/dev/loop)')  
uptime=$(uptime -s)
proc=$(ps -ef | wc -l)

clear
echo -e "==================================================================
Relatório da máquina: "$hostname"
Usuário logado: "$USER"
Data/Hora: $(date "+%d-%m-%Y %H:%M")
==================================================================
\nMáquina ativa desde: "$uptime"
\nSistema operacional: "$system"
Versão do Kernel: "$kernel"
\nCPUs:
Quantidade de CPUs/Core: "$cpuinfo"
Modelo da CPU: "$cpumodel"
\nMemória total: "$memtotal"
\nPartições: 
$filesys
\nTotal de processos em execução: "$proc"
=================================================================="

