#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Gera um arquivo com cabeçalho e permissão de execução
# Data de criação: 07/11/2021
# Data de modificação: 10/09/2023
# Versão: 1.7
# Uso: ./novo-script.sh <arquivo>

# Cabeçalho do script
cabecalho="#!/usr/bin/env bash
# Autor:
# Github:
# Descrição:
# Data de criação: $(date "+%d/%m/%Y")
# Data de modificação:
# Versão: 1.0
# Uso:
"

# Verifica se foi passado um nome de arquivo como argumento
if [ "$#" -ne 1 ]; then
  echo "Informe um nome para o arquivo!"
  exit 1
fi

# Verifica se o arquivo já existe
if [ -f "$1" ]; then
  echo "O arquivo já existe!"
  exit 1
fi


# Oferece opção de escolha do editor de texto
echo "Escolha um editor de texto:"
select editor in "Nano" "VI"; do
  case "$editor" in
  Nano)
    # Insere o cabeçalho, edita utilizando o nano e adiciona permissão de
		# execução.
    echo "$cabecalho" > "$1" && nano "$1" && chmod u+x "$1"
    break
    ;;
  VI)
    # Insere o cabeçalho, edita utilizando o vi e adiciona permissão de
		# execução.
    echo "$cabecalho" > "$1" && vi "$1" && chmod u+x "$1"
    break
    ;;
  *)
    echo "Opção inválida!"
    exit 1
    ;;
  esac
done

echo -e "\nCabeçalho inserido e arquivo criado: $1"

