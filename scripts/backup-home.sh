#!/usr/bin/env bash
# Autor: João Falcão
# Github: https://github.com/jplberserk
# Data de criação: 13/10/2021  
# Data de modificação: 28/07/2022  
# Versão: 1.6
# Uso: ./backup-home.sh

# Cria um backup completo do diretório "/home" do usuário logado.

destiny=$HOME/backup

# Testa se o diretório já existe.
if [ ! -d "$destiny" ]; then
	echo "Criando Diretório "$destiny"..."
	sleep 3
	mkdir -p "$destiny"
fi

# Verifica se o arquivo de backup foi criado a mais de 7 dias.
sevendays=$(find "$destiny" -ctime -7 -name backup-home\*.tar.gz)

# Testa se a variável NÃO é nula (se o arquivo de backup já existe).
if [ -n "$sevendays" ]; then
	echo "Já foi gerado um backup do diretório "$HOME" em "$destiny" nos últimos 7 dias."
	echo -n "Deseja continuar? (s|n): "
	read -n1 choice 
	echo
	case "$choice" in
		'N'|'n'|'" "')
			echo "Backup não realizado!"
			exit 1
			;;
		'S'|'s')
			echo "Será criado mais um backup para a mesma semana."
			;;
		*)
			echo "Opção Inválida!"
			exit 1
			;;
	esac
fi

echo "Criando Backup..."
sleep 3

# Criando o backup do "/home".
backupfile="backup-home-$(date "+%d%m%Y%H%M").tar.gz"

# Durante a criação, exclui o "backup anterior" para não fazer "BACKUP DO BACKUP".
tar -zcvf "$destiny"/"$backupfile" --exclude="$destiny" "$HOME"/* &> /dev/null

echo -e "O \""$backupfile"\" foi criado em "$destiny".\nBackup Concluído!"

