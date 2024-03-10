#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Jogo que pergunta sobre números aleatórios de 1 a 10
# Data de criação: 17/07/2023
# Data de modificação: 09/03/2024
# Versão: 1.4
# Uso: ./jogo-adivinhacao.sh

adivinhacao() {
    roleta=$((RANDOM % 10 + 1))

    echo -e "Estou pensando em um número de 1 a 10!\n"

    for ((i=5; i>=1; i--)); do
        echo -e "Em que número estou pensando? Você tem $i tentativas restantes..."
        read -p "> " resposta

        if [[ -z "$resposta" ]]; then
            echo "Não foi digitado nenhum caractere!"
            exit 1
        elif [[ ! "$resposta" =~ ^[[:digit:]]+$ ]]; then
            echo -e "Não foi digitado caracteres numéricos!"
            exit 1
        elif [[ "$roleta" -eq "$resposta" ]]; then
            echo -e "\nParabéns!!! Você acertou ;)"
            exit 0
        else
            echo -e "\nVocê errou!"
        fi
    done
    echo -e "Que pena :-( Estava pensando no número: $roleta"
}

adivinhacao

