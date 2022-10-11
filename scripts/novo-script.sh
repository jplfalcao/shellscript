#!/usr/bin/env bash
# Autor: João Falcão
# Github: https://github.com/jplberserk
# Data de criação: 07/11/2021  
# Data de modificação: 01/10/2022  
# Versão: 1.5
# Uso: ./novo-script.sh <arquivo>

# Script que gera um arquivo já com cabeçalho e permissão de execução.

# Comentários no cabeçalho do script.
cabecalho="#!/usr/bin/env bash
# Autor:
# Github:
# Decrição:
# Data de criação: `date "+%d/%m/%Y"` 
# Data de modificação:
# Versão: 1.0
"
# Verifica se foi passado algum parâmetro.
if [ $# -ne 1 ]; then
       echo "Informe o nome do arquivo!"
       exit 1
fi       

# Verifica se o arquivo já existe.
if [ -f $1 ]; then
	echo "Arquivo já existe!"
	exit 1
fi

# Insere o cabeçalho no inicio do arquivo.
echo "$cabecalho" > $1

# Adiciona permissão de execução.
chmod +x $1

# Cria o arquivo como editor VI.
vi $1

