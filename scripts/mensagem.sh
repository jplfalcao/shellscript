#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Apresenta uma mensagem de boas vindas
# Data de criação: 11/04/2022
# Data de modificação: 10/09/2023
# Versão: 1.6
# Uso: ./mensagem.sh

# Obtém a saudação com base na hora atual
saudacao() {
  local hora=$(date "+%H")
  if [ "$hora" -ge 06 ] && [ "$hora" -lt 12 ]; then
    echo "Bom dia ${USER^} - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y")."
  elif [ "$hora" -ge 12 ] && [ "$hora" -lt 18 ]; then
    echo "Boa tarde ${USER^} - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y")."
  else
    echo "Boa noite ${USER^} - hoje é $(date "+%A"), $(date "+%d") de $(date "+%B") de $(date "+%Y")."
  fi
}

# Armazena a saudação e imprime
mensagem=$(saudacao)
echo "$mensagem"

