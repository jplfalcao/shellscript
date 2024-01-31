#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Salva uma cópia antes de editar um arquivo
# Data de criação: 15/02/2022
# Data de modificação: 30/01/2024
# Versão: 1.5
# Uso: ./salva-antes-de-editar.sh <arquivo>

if [ "$#" -ne 1 ]; then
    echo "Informe o nome do arquivo!"
    exit 1
fi

if [ ! -e "$1" ]; then
    echo "O arquivo \"$1\" não existe!"

    read -r -n 1 -p "Deseja criar? (s|n): " escolha
    case "$escolha" in
        [Ss])
            touch "$1" && echo -e "\nArquivo \"$1\" criado!"
            exit 1
            ;;
        [Nn])
            echo -e "\nErro ao criar arquivo \"$1\"!"
            exit 1
            ;;
        *)
            echo -e "Opção inválida!"
            exit 1
    esac
fi

if [ ! -w "$1" ]; then
    echo "Você não tem permissão de escrita para o arquivo \"$1\"!"
    exit 1
fi

cp -a "$1" "$1.bkp"

echo "Escolha um editor de texto:"
select editor in "Nano" "VI"; do
    case "$editor" in
        Nano)
            nano "$1"
            break
            ;;
        VI)
            vi "$1"
            break
            ;;
        *)
            echo "Opção inválida!"
            exit 1
            ;;
    esac
done

