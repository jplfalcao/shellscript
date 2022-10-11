#!/usr/bin/env bash
# Autor: João Falcão
# Github: https://github.com/jplberserk
# Data de criação: 11/04/2022  
# Data de modificação: 06/10/2022  
# Versão: 1.3
# Uso: ./mensagem.sh

# Apresenta uma mensagem de boas vindas.

welcome1=$(echo "Bom dia "${USER^}" - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y").")
welcome2=$(echo "Bom tarde "${USER^}" - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y").")
welcome3=$(echo "Bom noite "${USER^}" - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y").")
hours=$(date "+%H")

if [ "$hours" -ge 06 ] && [ "$hours" -le 12 ]; then
	echo "$welcome1"
elif [ "$hours" -gt 12 ] && [ "$hours" -lt 18 ]; then
	echo "$welcome2"	
else
	echo "$welcome3"	
fi
