#!/usr/bin/env bash
set -e

PPA()
{
	##PPAs
	ppas=(
	##papirus-icon-theme
		papirus/papirus
	##hardcode-tray
		papirus/hardcode-tray
	)

	echo
	echo "-> Adicionando PPAs..."
	echo
	for ppa in ${ppas[@]}; do
		sudo apt-add-repository "ppa:"$ppa -y
	done
	echo
	echo "-> Feito"
	echo
	return
}

DEB()
{
	echo
	echo "-> Baixando arquivos .deb..."
	echo

	downloads=(
	##code (.deb/dpkg)
		"https://az764295.vo.msecnd.net/stable/5763d909d5f12fe19f215cbfdd29a91c0fa9208a/code_1.45.1-1589445302_amd64.deb"
	##chrome (.deb/dpkg)
		"https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
	##steam (.deb/dpkg)
		"https://repo.steampowered.com/steam/archive/precise/steam_latest.deb"
	##mega (.deb/dpkg)
		"https://mega.nz/linux/MEGAsync/xUbuntu_20.04/amd64/megasync-xUbuntu_20.04_amd64.deb"
		"https://mega.nz/linux/MEGAsync/xUbuntu_20.04/amd64/nautilus-megasync_3.6.6_amd64.deb"
		"https://mega.nz/linux/MEGAsync/xUbuntu_20.04/amd64/dolphin-megasync_4.1.1+4.1_amd64.deb"		
	##dropbox (.deb/dpkg)
		"https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb"
	)
	wget -c ${downloads[@]}

	echo
	echo "-> Feito"
	echo

	sudo apt -qq update

	echo
	echo "-> Instalando arquivos .deb..."
	echo
	sudo dpkg -i *.deb
	echo
	echo "-> Feito"
	echo
	return
}

APT()
{
	echo -n "Qual eh a DE ? (KDE: 0 // GNOME (GTK): 1) => "
	read DE

	pacotes_apt=(
	
	##Aplicativos
		qalculate
		papirus-icon-theme
		sublime-text
		timeshift
		gufw
		qbittorrent
		gnome-sudoku
		kdenlive
		gparted
		gnome-disk-utility
		hardinfo
		cpu-x
		gsmartcontrol

	##Aplicativos - Linha de comando
		neofetch
		htop
		gnuplot
		vnstat
		tlp
		hddtemp

	##Ferramentas
		smem
		git
		adb
		fastboot
		make
		cmake
		python3-pip

	#Desnecessarios/zoeira
		cmatrix
		libaa-bin
		oneko
		sl
		fortune

	##Shell
		zsh
	)

	pacotes_GNOME=(
		gnome-tweaks
		dconf-editor
		baobab
		tilix
		guake
		synaptic
		menulibre
	)

	pacotes_KDE=(
		kcalc
		kolourpaint
		skanlite
		filelight
		yakuake
		muon
		##Plugins
		dolphin-plugins
		kio-gdrive
		plasma-discover-flatpak-backend
	)

	##Chaves
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

    ##sublime-text (.deb)
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    ##virtual-box
    echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian focal contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

	echo
	echo "-> Instalando pacotes..."
	echo
    sudo apt update
	sudo apt -qq install ${pacotes_apt[@]} -y
	if [ $DE == "1" ];
	then
		echo "-> Instalando pacotes do GNOME..."
		sudo apt -qq install ${pacotes_GNOME[@]} -y
	elif [ $DE == "0" ];
	then
		echo "-> Instalando pacotes do KDE..."
		sudo apt -qq install ${pacotes_KDE[@]} -y
	fi

	sudo apt -qq install --install-recommends virtualbox-6.1

	wget -qO- https://git.io/papirus-folders-install | sh

	pips=(
		bpytop
	)

	pip3 install --user ${pips[@]}
	echo
	echo "-> Feito"
	echo
	return
}

CONTAINER()
{
	snaps=(
		scrcpy
	)

	flatpaks=(
		piper
		gimp
		spotify
		obs
		discord
		telegram
		onlyoffice
	)

	sudo apt install snapd flatpak
	flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo apt -qq update

	echo
	echo "-> Instalando snaps e flatpaks..."
	echo
	snap install ${snaps[@]}
	flatpak install ${flatpaks[@]}
	export PATH=$PATH:/snap/bin
	echo
	echo "-> Feito"
	echo
	return
}

ZSH()
{
	source /home/victorl/Dropbox/Scripts/Script_zsh_padrao.sh
	return
}

EXIT()
{
	sudo apt -qq dist-upgrade
	sudo apt -qq autoremove

	cd -

	echo
	echo "-> Tudo Feito! :D"
	echo "-> Encerrando..."
	echo
	exit
}

INICIO() {

	echo "|---------------------------------------------------------------|"
	echo "| Scrip de instalação de programas mais usados. By VLx 28/05/20 |"
	echo "|---------------------------------------------------------------|"
	echo

	timedatectl set-local-rtc 1 --adjust-system-clock
	sudo dpkg --add-architecture i386

	echo
	echo "-> Buscando atualizações!!!"
	echo
	sudo apt -qq update && sudo apt -qq dist-upgrade && sudo apt -qq install curl wget zenity -y

	echo
	echo "-> Criando pasta temporária para programas baixados"
	echo
	cd $(mktemp -d)

	echo
	echo "                    ---------------------------------"
	echo "                   |Opções:                          |"
	echo "                   |                                 |"
	echo "                   |      * BAIXAR E INSTALAR *      |"
	echo "                   |                                 |"
	echo "                   |     1. .debs                    |"
	echo "                   |     2. Pacotes apt e pip        |"
	echo "                   |     3. PPAs                     |"
	echo "                   |     4. Flatpaks e Snaps         |"
	echo "                   |     5. oh-my-zsh e fontes       |"
	echo "                   |                                 |"
	echo "                   |     0. FAZER TUDO!              |"
	echo "                   |                                 |"
	echo "                   |            Outro numero. SAIR...|"
	echo "                    ---------------------------------"
	echo
	echo -n "Qual a opção desejada? => "
	read opcao

	case $opcao in

		0) DEB ; PPA ; APT ; CONTAINER ; ZSH ; INICIO ;;

	    1) DEB ; INICIO ;;

	    2) APT ; INICIO ;;

	    3) PPA ; INICIO ;;

	    4) CONTAINER ; INICIO ;;

		5) ZSH ; INICIO ;;

	esac

	EXIT

}

INICIO
