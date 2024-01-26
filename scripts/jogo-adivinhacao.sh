#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Jogo que pergunta sobre números aleatórios de 1 a 10
# Data de criação: 17/07/2023
# Data de modificação: 25/01/2024
# Versão: 1.3
# Uso: ./jogo-adivinhacao.sh

# Definindo a função
adivinhacao() {
    # Gerando números inteiros aleatórios
    roleta=$((RANDOM % 10 + 1))

    echo -e "Estou pensando em um número de 1 a 10!\n"

    for ((i=5; i>=1; i--)); do
        echo -e "Em que número estou pensando? Você tem $i tentativas restantes..."
        read -p "> " resposta

        if [[ -z "$resposta" ]]; then
            echo "Não foi informado nenhum número!"
            exit 1
        # Testa se foi digitado caracteres alfabéticos
        elif [[ "$resposta" =~ ^[[:alpha:]]+$ ]]; then
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

# Chamando a função
adivinhacao

