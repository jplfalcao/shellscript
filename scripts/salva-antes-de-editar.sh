#!/usr/bin/env bash
# Autor: João Falcão
# Github: https://github.com/jplberserk
# Data de criação: 15/02/2022  
# Data de modificação: 04/10/2022  
# Versão: 1.2
# Uso: ./salva-antes-de-editar.sh <arquivo>

# Antes de editar um arquivo "X", salva uma cópia.

# Verifica se foi passado algum parâmetro.	
if [ "$#" -ne 1 ]; then
	echo "Informe o nome de arquivo!"
	exit 1
fi

file=$1
# Verifica se o arquivo NÂO existe.
if [ ! -f "$file" ]; then
	vi "$file"
	exit 0
fi

# Verifica se o arquivo possui permissão de escrita.
if [ ! -w "$file" ]; then	
	echo "Você não tem permissão de escrita no $file."
	exit 2
fi

cp -a "$file" "$file.bkp"
vi "$file"
exit 0
