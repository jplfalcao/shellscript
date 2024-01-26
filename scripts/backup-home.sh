#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Cria um backup completo do diretório "/home"
# Data de criação: 13/10/2021
# Data de modificação: 25/01/2024
# Versão: 1.9
# Uso: ./backup-home.sh

destino="$HOME/backup"

if [ ! -d "$destino" ]; then
    echo "Criando Diretório $destino..."
    mkdir -p "$destino"
    sleep 5
fi

# Verifica se o arquivo de backup foi criado a mais de 7 dias
setedias=$(find "$destino" -type f -ctime -7 -name 'backup-home*.tar.gz')

if [ -n "$setedias" ]; then
    echo "Já existe um backup do diretório \"$HOME\"."
    read -r -n 1 -p "Deseja continuar? (s|n): " escolha
    case "$escolha" in
        [Nn])
            echo -e "\nBackup não realizado!"
            exit 1
            ;;
        [Ss])
            echo -e "\nSerá criado mais um backup para a mesma semana."
            ;;
        *)
            echo -e "Opção Inválida!"
            exit 1
            ;;
    esac
fi

echo -e "Criando Backup...\n"
sleep 5

arquivobkp="backup-home-$(date "+%Y%m%d%H%M%S").tar.gz"

# Cria o arquivo de backup excluindo o "backup anterior"
tar -zcvf "$destino/$arquivobkp" --exclude="$destino" "$HOME"/* &> /dev/null

echo "Arquivo de backup criado: \"$arquivobkp\"."
echo -e "\nBackup Concluído!"

