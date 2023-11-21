#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Banco interativo
# Data de criação: 19/11/2023
# Data de modificação: 20/11/2023
# Versão: 1.1
# Uso: ./banco.sh

# Requisitos obrigatórios:

# 1 - Apenas um cliente por execução;
# 2 - Ao criar conta corrente, obrigatório perguntar se deseja realizar depósito inicial na conta corrente e criar automaticamente conta poupança;
# 3 - As contas necessitam de:
#   3.1 - Nome do titular;
#   3.2 - Agência;
#   3.3 - Número da conta;
#   3.4 - Dígito verificador.
# 4 - Operações na Conta Corrente:
#   4.1 - Saque;
#   4.2 - Depósito;
#   4.3 - Aplicar na conta poupança;
#   4.4 - Exibir saldo.
# 5 - Operações na Conta Poupança:
#   5.1 - Resgate;
#   5.2 - Exibir saldo.
# 6 - Necessário saldo para transferência entre contas.

qtdLetrasTitular=0
saldoContaCorrente=0.00
saldoContaPoupanca=0.00
valorDepositoInicial=0.00

saldo() {
    echo -e "$nomeTitular\nAgência: $agencia\nConta Corrente: $numeroContaCorrente-$digitoVerificador\
    \nSaldo Conta Corrente: R$ $saldoContaCorrente\nConta Poupança: $numeroContaPoupanca-$digitoVerificador\
    \nSaldo Conta Poupança: R$ $saldoContaPoupanca\n"
}

deposito() {
    read -r -p "Digite o valor do depósito: R$ " valorDeposito

    if (( $(bc -l <<< "$valorDeposito <= 0") )); then
        echo -e "\nDepósito não permitido!\n"
    else
        saldoContaCorrente=$(bc -l <<< "$saldoContaCorrente + $valorDeposito")
        echo -e "\nDepósito realizado com sucesso!\n"
    fi
}

saque() {
    read -r -p "Digite o valor do saque: R$ " valorSaque

    if (( $(bc -l <<< "$valorSaque <= 0") )); then
        echo -e "\nSaque não permitido!\n"
    elif (( $(bc -l <<< "$saldoContaCorrente < $valorSaque" ) )); then
        echo -e "\nSaldo insuficiente!\n"
    else
        saldoContaCorrente=$(bc -l <<< "$saldoContaCorrente - $valorSaque")
        echo -e "\nSaque realizado com sucesso!\n"
    fi
}

transferencia() {
    read -r -p "Digite o valor da transferência: R$ " valorTransferencia

    if (( $(bc -l <<< "$valorTransferencia <= 0") )); then
        echo -e "\nTransferência não permitida!\n"
    elif (( $(bc -l <<< "$saldoContaCorrente < $valorTransferencia") )); then
        echo -e "\nSaldo insuficiente!\n"
    else
        saldoContaCorrente=$(bc -l <<< "$saldoContaCorrente - $valorTransferencia")
        saldoContaPoupanca=$(bc -l <<< "$saldoContaPoupanca + $valorTransferencia")
        echo -e "\nTransferência realizada com sucesso!\n"
    fi
}

resgate() {
    read -r -p "Digite o valor do resgate: R$ " valorResgate

    if (( $(bc -l <<< "$valorResgate <= 0") )); then
        echo -e "\nResgate não permitido!\n"
    elif (( $(bc -l <<< "$saldoContaPoupanca < $valorResgate") )); then
        echo -e "\nSaldo insuficiente!\n"
    else
        saldoContaPoupanca=$(bc -l <<< "$saldoContaPoupanca - $valorResgate")
        saldoContaCorrente=$(bc -l <<< "$saldoContaCorrente + $valorResgate")
        echo -e "\nResgate realizado com sucesso!\n"
    fi
}

main() {
    while true; do
        echo -e "\$\$\$\$\$ BANCO ETE \$\$\$\$\$\n0-Criar Conta\n1-Exibir Saldo\n2-Depósito Conta Corrente\
        \n3-Saque Conta Corrente\n4-Aplicar Conta Poupança\n5-Resgate Conta Poupança\n6-Sair"

        read -r -p "Opção: " opcaoMenu

        clear

        case "$opcaoMenu" in
            0)
                if [ "$qtdLetrasTitular" -eq 0 ]; then
                    while true; do
                        read -r -p "Titular: " nomeTitular
                        if [[ "$nomeTitular" =~ ^[[:alpha:]]+$ ]]; then
                            break
                        else
                            echo "Digite apenas caracteres alfabéticos!"
                        fi
                    done

                    qtdLetrasTitular=${#nomeTitular}
                    agencia=$((RANDOM % 9000 + 1000))
                    numeroContaCorrente=$((RANDOM % 90000 + 10000))
                    numeroContaPoupanca=$((RANDOM % 90000 + 10000))
                    digitoVerificador=$((RANDOM % 10))

                    clear

                    echo -e "$nomeTitular\nAgência: $agencia\nConta Corrente: $numeroContaCorrente-$digitoVerificador\
                    \nConta Poupança: $numeroContaPoupanca-$digitoVerificador"
                else
                    echo -e "Não é permitido cadastrar novos clientes!\n"
                    continue
                fi

                read -r -p "Deseja realizar um depósito na Conta Corrente? [0-SIM][1-NÃO]: " opcaoDepositoInicial
                if [ "$opcaoDepositoInicial" -eq 0 ]; then
                    read -r -p "Valor do depósito: R$ " valorDepositoInicial
                    if (( $(bc -l <<< "$valorDepositoInicial <= 0") )); then
                        echo -e "\nDepósito não permitido!\n"
                    else
                        saldoContaCorrente=$(bc -l <<< "$saldoContaCorrente + $valorDepositoInicial")
                        echo -e "\nDepósito realizado com sucesso!\n"
                    fi
                else
                    clear
                fi
                ;;
            1)
                if [ "$qtdLetrasTitular" -eq 0 ]; then
                    echo -e "Ainda não há conta cadastrada!\n"
                else
                    saldo
                fi
                ;;
            2)
                if [ "$qtdLetrasTitular" -eq 0 ]; then
                    echo -e "Ainda não há conta cadastrada!\n"
                else
                    deposito
                fi
                ;;
            3)
                if [ "$qtdLetrasTitular" -eq 0 ]; then
                    echo -e "Ainda não há conta cadastrada!\n"
                else
                    saque
                fi
                ;;
            4)
                if [ "$qtdLetrasTitular" -eq 0 ]; then
                    echo -e "Ainda não há conta cadastrada!\n"
                else
                    transferencia
                fi
                ;;
            5)
                if [ "$qtdLetrasTitular" -eq 0 ]; then
                    echo -e "Ainda não há conta cadastrada!\n"
                else
                    resgate
                fi
                ;;
            6)
                echo -e "Saindo...\n"
                break
                ;;
            *)
                echo -e "Opção inválida!\n"
                ;;
        esac
    done
}

main
