#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Calculadora que efetuará as quatro operações básicas
# Data de criação: 07/06/2023
# Data de modificação: 09/03/2024
# Versão: 1.4
# Uso: ./calculadora.sh

# Verifique se o pacote `bc` está instalado em sua distribuição

clear

echo -e ">>>Calculadora<<<"

while true; do
    read -r -p "Digite o primeiro número: " numero1
    read -r -p "Digite o segundo número: " numero2

    if [[ -z "$numero1" || -z "$numero2" ]]; then
        echo -e "Não foi passado (ou falta) parâmetros!"
        continue
    elif [[ ! "$numero1" =~ ^[[:digit:]]+$ || ! "$numero2" =~ ^[[:digit:]]+$ ]]; then
        echo -e "Não foi detectado caracteres numéricos!"
        continue
    else
        break
    fi
done

echo -e "\n>>>Operações Aritméticas<<<"
select operacao in "Adicao" "Subtracao" "Multiplicacao" "Divisao" "Sair"; do
    case "$operacao" in
        Adicao) echo "Resultado: $(bc <<< "$numero1 + $numero2")";;
        Subtracao) echo "Resultado: $(bc <<< "$numero1 - $numero2")";;
        Multiplicacao) echo "Resultado: $(bc <<< "$numero1 * $numero2")";;
        Divisao)
            if [[ "$numero2" == 0 ]]; then
                echo "Não é permitido divisão por zero!"
            else
                echo "Resultado: $(bc <<< "scale=1; $numero1 / $numero2")"
            fi
            ;;
        Sair) break;;
        *) echo -e "Opção Inválida!";;
    esac
done

