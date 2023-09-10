#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Salva uma cópia antes de editar um arquivo
# Data de criação: 15/02/2022
# Data de modificação: 10/09/2023
# Versão: 1.4
# Uso: ./salva-antes-de-editar.sh <arquivo>

# Verifica se foi passado algum parâmetro
if [ "$#" -ne 1 ]; then
  echo "Informe o nome do arquivo!"
  exit 1
fi

arquivo="$1"

# Verifica se o arquivo NÃO existe
if [ ! -e "$arquivo" ]; then
  echo "O arquivo \"$arquivo\" não existe"
  # Oferece opção de escolha
  read -r -n 1 -p "Deseja criar? (s|n): " escolha
  case "$escolha" in
    [Ss])
      touch "$arquivo" && echo -e "\nArquivo \"$arquivo\" criado!"
      exit 1
      ;;
    [Nn])
      echo -e "\nErro ao criar arquivo \"$arquivo\"!"
      exit 1
      ;;
    *)
      echo -e "Opção inválida!"
      exit 1
  esac
fi

# Verifica se o arquivo possui permissão de escrita
if [ ! -w "$arquivo" ]; then
  echo "Você não tem permissão de escrita para o arquivo \"$arquivo\"!"
  exit 1
fi

# Realizando a cópia
cp -a "$arquivo" "$arquivo.bkp"
vi "$arquivo"

