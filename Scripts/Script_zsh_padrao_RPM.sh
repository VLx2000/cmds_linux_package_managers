#!/usr/bin/env bash
set -e

sudo dnf install git curl zsh -y

echo "Instalando fontes para o terminal"

if [ -d ~/.fonts ];then
  # se o diretório existir
  touch ~/.fonts
else
  # se não existir, vai ser criado o diretório
  mkdir ~/.fonts
fi
cd ~/.fonts
wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/Hack.zip
unzip Hack.zip
wget -c https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -c https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -c https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -c https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
cd -

cd ~
echo "-> Mudando shell padrão para o zsh e baixando oh-my-zsh..."
if [ -d ~/.oh-my-zsh ];then
	sudo usermod --shell $(which zsh) $USER
	echo "oh-my-zsh já baixado"
else
	sudo usermod --shell $(which zsh) $USER
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

	##ZSH_THEME="powerlevel10k/powerlevel10k"
	sed -i 's_robbyrussell_powerlevel10k/powerlevel10k_g' ~/.zshrc
	##plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
	sed -i 's/git/git zsh-autosuggestions zsh-syntax-highlighting/g' ~/.zshrc

	echo "
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias myip='curl ifconfig.me'
alias dados_movendo='watch grep -e Dirty: -e Writeback: /proc/meminfo'
alias up='sudo dnf update && flatpak update'
alias mnt='df -h | grep -i '/dev/sd''
" >> ~/.zshrc

	#export PATH=:~/.local/bin
	#export PATH=:~/.cargo/bin

	#alias conserta_opera='sudo cp /home/victorl/Programas/opera_codecs/libffmpeg.so /lib/x86_64-linux-gnu/opera/lib_extra/'
	#alias rkde='kquitapp5 plasmashell && kstart5 plasmashell'
	#alias tema_grub="cd /home/victorl/Grub-Theme/matter/ && ./matter.py -i microsoft-windows ubuntu chip chip chip chip chip chip chip cog -bg black -fs 20 -hl 315bef && cd -"
	#function mem()
	#{
	#	smem -t -k -c pss -P "$1" | tail -n 1
	#}
	#function automute() 
	#{
	#	amixer -c 0 sget "Auto-Mute Mode" |\
	#	fgrep -q "Item0: 'E" && _M=Disabled ||\
	#	_M=Enabled; amixer -c 0 sset "Auto-Mute Mode" $_M
	#}
	#function system()
	#{
	#	qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.qtproject.Qt.QWidget.showMaximized &&
	#	qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.kde.KMainWindow.activateAction split-view-left-right &&
	#	qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.kde.KMainWindow.activateAction split-view-top-bottom &&
	#	qdbus $KONSOLE_DBUS_SERVICE /Sessions/1 org.kde.konsole.Session.runCommand "bpytop" &&
	#	qdbus $KONSOLE_DBUS_SERVICE /Sessions/2 org.kde.konsole.Session.runCommand "nvtop" &&
	#	qdbus $KONSOLE_DBUS_SERVICE /Sessions/3 org.kde.konsole.Session.runCommand "neofetch"
	#}
	#function dados_sistema()
	#{
	#	qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.qtproject.Qt.QWidget.showMaximized &&
	#	qdbus $KONSOLE_DBUS_SERVICE /konsole/MainWindow_1 org.kde.KMainWindow.activateAction split-view-top-bottom &&
	#	qdbus $KONSOLE_DBUS_SERVICE /Sessions/1 org.kde.konsole.Session.runCommand "bpytop" &&
	#	qdbus $KONSOLE_DBUS_SERVICE /Sessions/2 org.kde.konsole.Session.runCommand "nvtop" 
	#}
	#	function update_grive()
	#	{
	#		cd /home/victorl/Programas/Grive/grive2/
	#		git pull
	#		cd build
	#		cmake ..
	#		make -j4
	#		sudo make install
	#	}
	#	alias update_drive="cd /mnt/Arquivos/Google\ Drive/ && grive && cd -"
	# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
	#echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc
	echo "Feito! :D Agora reinicie e rode p10k configure"
fi
cd -