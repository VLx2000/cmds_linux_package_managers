#!/usr/bin/env bash
set -e

echo "Scrip de instalação de programas mais usados. By VLx 28/05/20"

timedatectl set-local-rtc 1 --adjust-system-clock

echo "-> Buscando atualizações!!!"
sudo apt update && sudo apt dist-upgrade

echo "-> Criando pasta temporária para programas baixados"
cd $(mktemp -d)
sudo apt install curl wget

##Chaves
##curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

##PPAs
ppas=(
##papirus-icon-theme
papirus/papirus
##timeshift
teejee2008/ppa
##hardcode-tray
papirus/hardcode-tray
)

echo "-> Adicionando PPAs..."
for ppa in ${ppas[@]}; do
  sudo apt-add-repository "ppa:"$ppa -y
done
echo "-> Feito"

echo "-> Baixando arquivos .deb..."
##spotify-client (.deb) 
	##echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
##sublime-text (.deb)
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
##virtual-box
	echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

downloads=(
##code (.deb/dpkg)
	"https://az764295.vo.msecnd.net/stable/5763d909d5f12fe19f215cbfdd29a91c0fa9208a/code_1.45.1-1589445302_amd64.deb"
##chrome (.deb/dpkg)
	"https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
##steam (.deb/dpkg)
	"https://repo.steampowered.com/steam/archive/precise/steam_latest.deb"
##mega (.deb/dpkg)
	"https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb"
	"https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/dolphin-megasync-xUbuntu_18.04_amd64.deb"
##dropbox (.deb/dpkg)
	"https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb"
)
wget -c ${downloads[@]}

echo "-> Feito"

sudo apt update

echo "-> Instalando arquivos .deb..."
sudo dpkg -i *.deb
echo "-> Feito"

cd ~

pacotes_apt=(

##Aplicativos
papirus-icon-theme
hardcode-tray
timeshift
gufw
netbeans
kolourpaint
skanlite
qbittorrent
gnome-sudoku
elisa
kdenlive
muon
gparted
gnome-disk-utility
colord-kde
kcalc
filelight
hardinfo
sublime-text
##obs-studio
##spotify-client
##virtualbox

##Aplicativos - Linha de comando
neofetch
htop
gnuplot
vnstat
tlp
hddtemp

##Ferramentas
git
adb
fastboot
curl
wget
make
cmake
zenity

##Plugins
dolphin-plugins
kio-gdrive

#Desnecessarios/zoeira
cmatrix
libaa-bin
oneko
sl
fortune

##Shell
zsh
)

sudo apt install ${pacotes_apt[@]} -y
sudo apt install --install-recommends virtualbox-6.1

wget -qO- https://git.io/papirus-folders-install | sh

snaps=(
	scrcpy
)

flatpaks=(
	piper
	gimp
	spotify
	obs-studio
	discord
	telegram
)

sudo dpkg --add-architecture i386
sudo apt install snapd flatpak
##sudo apt install plasma-discover-flatpak-backend
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo apt update

echo "-> Instalando snaps e flatpaks..."
snap install ${snaps[@]}
flatpak install ${flatpaks[@]}
export PATH=$PATH:/snap/bin  

sudo apt dist-upgrade
sudo apt autoremove

echo "-> Tudo Feito! :D"
echo "-> Encerrando..."