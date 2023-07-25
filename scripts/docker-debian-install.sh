#!/usr/bin/env bash
# Autor: João PauLo Falcão
# Github: https://github.com/jplfalcao
# Descrição: Instalação do Docker CE em servidores GNU/Linux Debian
# Data de criação: 04/04/2023
# Data de modificação: 21/07/2023
# Versão: 1.3
# Uso: ./docker-debian-install.sh

# Criando arquivo de log
log=("$PWD/$(echo "$0" | cut -d'/' -f2).log")

# Variável que identifica o usuário
userID=$(id -u)

# Verificando se o usuário é root
if [ "$userID" == "0" ]; then
	echo -e "Usuário é root. Continuando...\n"
	sleep 5
else
	echo -e "Usuário não é root. Saindo!\n"
	exit 1
fi

# Atualizando o sistema
echo -e "Atualizando o sistema..."
	apt-get update &>> "$log"
	apt-get upgrade -y &>> "$log"
echo -e "Sistema atualizado. Continuando... \n"
sleep 5

# Removendo pacotes
echo -e "Removendo pacotes desnecessários..."
	apt-get autoclean -y &>> "$log"
	apt-get autoremove -y &>> "$log"
echo -e "Pacotes removidos. Continuando... \n"
sleep 5

# Instalando o Docker CE
# Função que será utilizada para instalar o Docker CE
dockerinstall() {
	apt-get install -y ca-certificates curl gnupg &>> "$log"
	mkdir -m 0755 -p /etc/apt/keyrings &>> "$log"
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg &>> "$log"
	echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
	"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
	tee /etc/apt/sources.list.d/docker.list &>> "$log"
	chmod 644 /etc/apt/keyrings/docker.gpg &>> "$log"
	apt-get update &>> "$log"
	apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &>> "$log"
}

# Variável que verifica se o Docker CE já está instalado
verificadocker=$(dpkg -l | grep -i docker-ce)

echo -e "Instalando o Docker CE..."
if [ "$verificadocker" ] &> /dev/null; then
	echo -e "O Docker CE já está instalado. Continuando...\n"
	sleep 5
else
	# Chamando a função de instalação
	dockerinstall
	echo -e "Instalação do Docker CE concluída. Continuando...\n"
	sleep 5
fi

# Adicionando aliases
# Variável que adicionará os recursos ao arquivo /etc/bash.bashrc
aliases="alias rm='rm -i'\nalias cp='cp -i'\nalias mv='mv -i'\nalias grep='grep --color=auto'\
\nalias ls='ls --color=auto'\nalias vi='/usr/bin/vim'"

# Filtro de pesquisa para os aliases
filtroalias=$(grep -E "alias (rm|cp|mv|grep|ls|vi)=" /etc/bash.bashrc)

echo -e "Adicionando aliases ao arquivo /etc/bash.bashrc..."
if [ -z "$filtroalias" ]; then
	echo -e "$aliases" >> /etc/bash.bashrc
	source /etc/bash.bashrc
	echo -e "Aliases adicionados com sucesso. Continuando...\n"
	# Ao finalizar o script, precisa recarregar sua sessão, com o comando `exit`, para
	# habilitar os aliases
	sleep 5
else
	echo -e "Aliases já foram adicionados ao arquivo /etc/bash.bashrc. Continuando...\n"
	sleep 5
fi

# Adicionando recursos ao `vim`
# Variável que adicionará os recursos ao arquivo
recvim="syntax on\nset number\nset autoindent\nset tabstop=4\nset cursorline\nset cursorcolumn\nset paste"

# Filtro de pesquisa para o `vim`
filtrovim=$(grep -E "set (number|autoindent|tabstop=4|cursorline|cursorcolumn|paste)" /etc/vim/vimrc)

echo -e "Adicionando recursos ao arquivo /etc/vim/vimrc..."
if [ -z "$filtrovim" ]; then
	echo -e "$recvim" >> /etc/vim/vimrc
	echo -e "Recursos adicionados com sucesso.\n"
	sleep 5
else
	echo -e "Recursos já estão adicionados ao arquivo /etc/vim/vimrc.\n"
	sleep 5
fi

echo -e "Instalação concluída!"