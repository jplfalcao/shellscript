#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Antes de editar um arquivo salva uma cópia
# Data de criação: 15/02/2022
# Data de modificação: 21/07/2023
# Versão: 1.3
# Uso: ./salva-antes-de-editar.sh <arquivo>

# Verifica se foi passado algum parâmetro
if [ "$#" -ne 1 ]; then
	echo "Informe o nome de arquivo!"
	exit 1
fi

file=$1
# Verifica se o arquivo NÂO existe
if [ ! -f "$file" ]; then
	vi "$file"
	exit 0
fi

# Verifica se o arquivo possui permissão de escrita
if [ ! -w "$file" ]; then
	echo "Você não tem permissão de escrita no arquivo \"$file\"."
	exit 1
fi

# Realizando a cópia
cp -a "$file" "$file.bkp"
vi "$file"
exit 0