#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Cria um backup completo do diretório "/home"
# Data de criação: 13/10/2021
# Data de modificação: 10/09/2023
# Versão: 1.8
# Uso: ./backup-home.sh

# Variável que define o caminho do backup
destino="$HOME/backup"

# Testa se o diretório já existe
if [ ! -d "$destino" ]; then
  echo "Criando Diretório $destino..."
  mkdir -p "$destino"
  sleep 5
fi

# Verifica se o arquivo de backup foi criado a mais de 7 dias
setedias=$(find "$destino" -type f -ctime -7 -name 'backup-home*.tar.gz')

# Testa se a variável NÃO é nula
if [ -n "$setedias" ]; then
  echo "Já foi gerado um backup do diretório \"$HOME\" no diretório \"$destino\" nos últimos 7 dias."
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

# Criando o backup do "/home"
arquivobkp="backup-home-$(date "+%Y%m%d%H%M%S").tar.gz"

# Durante a criação, exclui o "backup anterior" para não fazer "BACKUP DO BACKUP"
tar -zcvf "$destino/$arquivobkp" --exclude="$destino" "$HOME"/* &> /dev/null

echo "O arquivo de backup \"$arquivobkp\" foi criado no diretório \"$destino\"."
echo -e "\nBackup Concluído!"

