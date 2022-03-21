#!/bin/bash

echo "Make sure you're running this as the correct user you want to install the files on.  Note: If you run this with sudo, it will replace root user files."
echo "To update current user files just run: ./setup.sh"

echo "Updating files for $(whoami).  Continue?(y/n)"
read answer

#If answer y or Y then continue else stop
[ "${answer}" == 'y' ] || [ "${answer}" == 'Y' ] && echo "Replacing files in home dir for user $(whoami) . . ." || exit

rm ~/.bash_aliases
rm ~/.bashrc
rm ~/.profile
rm ~/.vimrc

ln -rs bash_aliases ~/.bash_aliases
ln -rs bashrc ~/.bashrc
ln -rs profile ~/.profile
ln -rs vimrc ~/.vimrc

#Install neovim.
declare -A osInfo;

osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x  ./nvim.appimage
sudo mv ./nvim.appimage /usr/local/bin/

for f in ${!osInfo[@]}
do
	if [[ -f $f ]]; then
		echo package manager: ${osInfo[$f]}
		if [ ${osInfo[$f]} == 'apt' ]; then

            # code linters for neovim, necessary for syntactic highlighting
            #sudo apt install flake8 pylint
            #sudo apt install golint
            #sudo apt install checkstyle
            sudo apt install npm
            sudo apt install rust-src
            sudo apt install golang-go &
            python3 -m pip install pynvim &
            sudo apt install python3-autopep8
            echo "Setting up neovim . . ."

		elif [ ${osInfo[$f]} == 'yum' ]; then
            echo "Custom code linters for neovim not installed.  You will need to yum install them manually."
            echo "Examples:  flake8, pylint, golint, checkstyle"

		else 
            curl --proto'=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
            pip install pynvim &
			echo 'Note: You will need to install neovim with your systems package manager.  Otherwise, disable nvim plugins in .vimrc.'
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


# Install nvim.packer for lsp
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvimc
mkdir -p ~/.config/nvim/lua/
mkdir -p /usr/local/share/lua/5.1/
sudo ln -s $(pwd)/plugins.lua /usr/local/share/lua/5.1/ 
ln -s plugins.lua ~/.config/nvim/lua/plugins.lua

# Install nvim LSP for more:  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqls
    # pyright is a python language server 
npm -i -g pyright
    
    # rust analyzer is a rust language server , not you may need to install rust-src
sudo curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ./rust-analyzer
chmod +x ./rust-analyzer
sudo mv ./rust-analyzer /usr/local/bin/rust-analyzer

    # bash-language-server is a bash language server  -- might be causing bash files to lag in vim
sudo npm -g install bash-language-server &

    # LSP for sql -- had problems installing this one.
sudo go get github.com/lighttiger2505/sqls &

    # Scala LSP
        # coursier for metals 
curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | gzip -d > cs
chmod +x cs
./cs setup
sudo mv cs /usr/local/bin/cs
#cs istall metals # metals plugin should handle this.


echo "NOTE: To use ssm, you need to configure /usr/local/bin/ssm/.env and ~/.ssh/hosts.csv according to the ssm README (/usr/local/bin/ssm/README.md)."
echo 'Finished.'
