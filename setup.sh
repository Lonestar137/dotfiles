#!/bin/bash

echo "Make sure you're running this as the correct user you want to install the files on.  Note: If you run this with sudo, it will replace root user files."
echo "To update current user files just run: ./setup.sh"

echo "Updating files for $(whoami).  Continue?(y/n)"
read answer

#If answer y or Y then continue else stop
[ "${answer}" == 'y' ] || [ "${answer}" == 'Y' ] && echo "Replacing files in home dir for user $(whoami) . . ." || exit

rm ~/.bash_aliases
rm ~/.bashrc
#rm ~/.profile
rm ~/.vimrc

ln -rs bash_aliases ~/.bash_aliases
ln -rs bashrc ~/.bashrc
#ln -rs profile ~/.profile
ln -rs vimrc ~/.vimrc

#Install neovim.
declare -A osInfo;

osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt

for f in ${!osInfo[@]}
do
	if [[ -f $f ]]; then
		echo package manager: ${osInfo[$f]}
		if [ ${osInfo[$f]} == 'apt' ]; then
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
            sudo chmod u+x  ./nvim.appimage
            sudo mv ./nvim.appimage /usr/local/bin/

		elif [ ${osInfo[$f]} == 'yum' ]; then
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
            sudo chmod u+x  ./nvim.appimage
            sudo mv ./nvim.appimage /usr/local/bin/
        else
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
            sudo chmod u+x  ./nvim.appimage
            sudo mv ./nvim.appimage /usr/local/bin/
		#else 
		#	echo 'Note: You will need to install neovim with your systems package manager.  Otherwise, disable nvim plugins in .vimrc.'
		fi 
	fi
done



#Installing z fuzzy finder command by Rupa
sudo git clone https://github.com/rupa/z.git /usr/local/bin/z && echo "z fuzzy finder installed at /usr/local/bin/z" || echo "z already installed."
sudo git clone https://github.com/lonestar137/ssm.git /usr/local/bin/ssm && echo "ssm installed at /usr/local/bin/ssm" || echo "ssm already installed."

# ssm setup
sudo mv /usr/local/bin/ssm/env /usr/local/bin/ssm/.env
mkdir -p ~/.ssh/
touch ~/.ssh/hosts.csv

# Link up nvim with .vimrc
mkdir -p ~/.config/nvim/
echo '
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
' > ~/.config/nvim/init.vim


echo "NOTE: To use ssm, you need to configure /usr/local/bin/ssm/.env and ~/.ssh/hosts.csv according to the ssm README (/usr/local/bin/ssm/README.md)."
echo 'Finished.'
