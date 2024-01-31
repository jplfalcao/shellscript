#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Cria um arquivo com cabeçalho e permissão de execução
# Data de criação: 07/11/2021
# Data de modificação: 30/01/2024
# Versão: 1.8
# Uso: ./novo-script.sh <arquivo>

cabecalho="#!/usr/bin/env bash
# Autor:
# Github:
# Descrição:
# Data de criação: $(date "+%d/%m/%Y")
# Data de modificação:
# Versão: 1.0
# Uso:
"

if [ "$#" -ne 1 ]; then
    echo "Informe um nome para o arquivo!"
    exit 1
fi

if [ -f "$1" ]; then
    echo "O arquivo já existe!"
    exit 1
fi

echo "Escolha um editor de texto:"
select editor in "Nano" "VI"; do
    case "$editor" in
        Nano)
            echo "$cabecalho" > "$1" && nano "$1" && chmod u+x "$1"
            break
            ;;
        VI)
            echo "$cabecalho" > "$1" && vi "$1" && chmod u+x "$1"
            break
            ;;
        *)
            echo "Opção inválida!"
            exit 1
            ;;
    esac
done

echo -e "\nCabeçalho inserido e arquivo criado: $1"

