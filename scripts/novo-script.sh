#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Script que gera um arquivo já com cabeçalho e permissão de execução
# Data de criação: 07/11/2021
# Data de modificação: 21/07/2023
# Versão: 1.6
# Uso: ./novo-script.sh <arquivo>

# Comentários no cabeçalho do script
cabecalho="#!/usr/bin/env bash
# Autor:
# Github:
# Descrição:
# Data de criação: $(date "+%d/%m/%Y")
# Data de modificação:
# Versão: 1.0
# Uso:
"

# Verifica se foi passado algum parâmetro
if [ "$#" -ne 1 ]; then
    echo "Informe um nome para o arquivo!"
    exit 1
fi

# Verifica se o arquivo já existe
if [ -f "$1" ]; then
	echo "O arquivo já existe!"
	exit 1
fi

# Insere o cabeçalho no inicio do arquivo
echo "$cabecalho" > "$1"

# Adiciona permissão de execução
chmod u+x "$1"

# Cria o arquivo como editor VI
vi "$1"