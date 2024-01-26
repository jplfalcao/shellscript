#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Calculadora que efetuará as quatro operações básicas
# Data de criação: 07/06/2023
# Data de modificação: 25/01/2024
# Versão: 1.3
# Uso: ./calculadora.sh

# Verifique se o pacote `bc` está instalado em sua distribuição

clear

echo -e ">>>Calculadora<<<"

while true; do
    read -r -p "Digite o primeiro número: " num1
    read -r -p "Digite o segundo número: " num2

    # Testa se as duas variáveis estão com valor nulo
    if [[ -z "$num1" || -z "$num2" ]]; then
        echo -e "Não foi passado (ou falta) parâmetros!"
        continue
    # Testa se foi digitado caracteres alfabéticos
    elif [[ "$num1" && "$num2" =~ ^[[:alpha:]]+$ || "$num2" && "$num1" =~ ^[[:alpha:]]+$ ]]; then
        echo -e "Não foi detectado caracteres numéricos!"
        continue
    else
        break
    fi
done

echo -e "\n>>>Operações Aritméticas<<<"
select calc in "Adicao" "Subtracao" "Multiplicacao" "Divisao" "Sair"; do
    case "$calc" in
        Adicao) echo "Resultado: $(bc <<< "$num1 + $num2")";;
        Subtracao) echo "Resultado: $(bc <<< "$num1 - $num2")";;
        Multiplicacao) echo "Resultado: $(bc <<< "$num1 * $num2")";;
        Divisao) echo "Resultado: $(bc <<< "scale=2; $num1 / $num2")";;
        Sair) break;;
        *) echo -e "Opção Inválida!";;
    esac
done

