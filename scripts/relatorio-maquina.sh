#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Apresenta o relatório de um host GNU/Linux
# Data de criação: 28/10/2021
# Data de modificação: 21/07/2023
# Versão: 1.6
# Uso: ./relatorio-maquina.sh

# O script foi testado em servidores Debian e CentOS

# Variáveis utilizadas para realizar os filtros
kernel=$(uname -r)
hostname=$(hostnamectl | grep 'hostname' | tr -d ' ' |  cut -d':' -f2)
system=$(hostnamectl | grep 'System' | tr -d ' ' | cut -d':' -f2)
cpuinfo=$(grep -c "model name" /proc/cpuinfo)
cpumodel=$(grep "model name" /proc/cpuinfo | head -n1 | cut -c14-)
memtotal=$(free -h | grep "Mem" | tr -d ' ' | cut -c5-8)
filesys=$(df -hT | grep -Ev '(tmpfs|udev|loop)')
uptime=$(uptime -s)
proc=$(ps -aux | sed '1d' | wc -l)
endip=$(ip -o a | grep -E "(eth|enp|ens|wlx).*" | awk '{print $4}' | head -n1)

clear

# Saída do script
echo -e "==================================================================
Relatório da máquina: $hostname
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