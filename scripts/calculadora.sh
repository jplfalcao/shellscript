#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Calculadora que será utilizada para efetuar as quatro operações básicas
# Data de criação: 07/06/2023
# Data de modificação: 21/07/2023
# Versão: 1.1
# Uso: ./calculadora.sh

# Verifique se o pacote `bc` está instalado em sua distribuição

clear

echo -e ">>>Calculadora Simples<<<"
read -r -p "Digite o primeiro número: " num1
read -r -p "Digite o segundo número: " num2
# Testa se as duas variáveis tem valor nulo
if [[ ( -z "$num1" ) || ( -z "$num2" ) ]]; then
    echo "Não foi passado (ou falta) parâmetros!"
    exit 1
# Testa se foi digitado letras
elif [[ "$num1" && "$num2" =~ ^[[:alpha:]]+$ || "$num2" && "$num1" =~ ^[[:alpha:]]+$ ]]; then
    echo -e "Não foi detectado caracteres numéricos!"
    exit 1
else
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
fi