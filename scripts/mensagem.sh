#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Apresenta uma mensagem de boas vindas
# Data de criação: 11/04/2022
# Data de modificação: 22/07/2023
# Versão: 1.5
# Uso: ./mensagem.sh

# Variáveis que armazenam as mensagens apresentadas na saída
bemvindo1="Bom dia ${USER^} - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y")."
bemvindo2="Boa tarde ${USER^} - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y")."
bemvindo3="Boa noite ${USER^} - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y")."

# Variável de controle baseado na hora atual
hora=$(date "+%H")

# Testando a variável 'hora' e apresentando a mensagem correspondente
if [ "$hora" -ge 06 ] && [ "$hora" -lt 12 ]; then
	echo "$bemvindo1"
elif [ "$hora" -gt 12 ] && [ "$hora" -lt 18 ]; then
	echo "$bemvindo2"
else
	echo "$bemvindo3"
fi
