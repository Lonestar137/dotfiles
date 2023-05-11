#!/bin/bash

echo "Make sure you're running this as the correct user you want to install the files on.  Note: If you run this with sudo, it will replace root user files."
echo "To update current user files just run: ./setup.sh"
echo "Updating files for $(whoami).  Continue?(y/n)"
read answer

#If answer y or Y then continue else stop
[ "${answer}" == 'y' ] || [ "${answer}" == 'Y' ] && echo "Beginning with install. . ." || exit


declare -Ag OSINFO;

OSINFO[/etc/redhat-release]=yum
OSINFO[/etc/arch-release]=pacman
OSINFO[/etc/gentoo-release]=emerge
OSINFO[/etc/SuSE-release]=zypp
OSINFO[/etc/debian_version]=apt

linkDotFiles(){
    echo "Replacing files in home dir for user $(whoami) . . ."
    rm ~/.bash_aliases
    rm ~/.bashrc
    #rm ~/.profile
    rm ~/.vimrc

    ln -rs bash_aliases ~/.bash_aliases
    ln -rs bashrc ~/.bashrc
    #ln -rs profile ~/.profile
    ln -rs vim/vimrc ~/.vimrc
}

setupVSCode(){
    ln -s $(pwd)/config/vscode/ ~/.config/.vscode/
}

setupNvimLSP(){
    sudo npm i -g pyright 
    sudo npm i -g bash-language-server
    #sudo apt install flake8 pylint
    sudo apt install flake8 golint 
    #sudo apt install checkstyle

}

installNeovim(){
    echo "Setting up Neovim . . ."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    sudo chmod u+x  ./nvim.appimage
    sudo mv ./nvim.appimage /usr/local/bin/
    
    # Link up nvim with .vimrc
    mkdir -p ~/.config/nvim/
    ~/.config/nvim/init.vim
    
    # Install nvim.packer for lsp
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvimc
    mkdir -p ~/.config/nvim/lua/
    mkdir -p /usr/local/share/lua/5.1/
    ln -s $(pwd)/vim/plugins.lua /usr/local/share/lua/5.1/ 
    ln -s $(pwd)/vim/plugins.lua ~/.config/nvim/lua/plugins.lua
    ln -s $(pwd)/vim/init.lua ~/.config/nvim/init.lua
    ln -s $(pwd)/vim/neovimrc.vim ~/.config/nvim/neovimrc.vim

    setupVSCode
    setupNvimLSP
}

setupSSHkeys(){
    echo "If you need a SSHKey do: ssh-keygen -t rsa -b 4096 && sudo chmod 600 ~/.ssh/*"
    echo "To copy ID to a SSH server: ssh-copy-id username@server-ip"
    sudo touch ~/.ssh/authorized_keys
    sudo chmod 700 ~/.ssh
    sudo chmod 600 ~/.ssh/*
    # TODO: detect system ps manager, firewall, and allow ssh
}


packageManagerSpecficInstalls(){
    for f in ${!OSINFO[@]}
        do
            if [[ -f $f ]]; then
                echo package manager: ${OSINFO[$f]}
                if [ ${OSINFO[$f]} == 'apt' ]; then
                    sudo apt update

                    # code linters for neovim, necessary for syntactic highlighting
                    sudo apt install npm
                    sudo apt install rust-src
                    sudo apt install golang-go
                    sudo apt install dotnet-sdk-6.0
                    # python3 -m pip install pynvim &
                    # sudo apt install python3-autopep8

                    # Automatic PAT saving for Github, Gitlab
                    sudo apt install git-core
                    git config --global credential.helper store
                    sudo apt install openssh-server openssh-client
                    setupSSHkeys

                elif [ ${OSINFO[$f]} == 'yum' ]; then
                    echo "Custom code linters for neovim not installed.  You will need to yum install them manually."
                    echo "Examples:  flake8, pylint, golint, checkstyle"

                else 
                    echo "Unrecognized package manager"
                fi 
            fi
        done
}

installZ(){
    #Installing z fuzzy finder command by Rupa
    sudo git clone https://github.com/rupa/z.git /usr/local/bin/z && echo "z fuzzy finder installed at /usr/local/bin/z" || echo "z already installed."
}

installI3(){
    echo "Setting up i3wm . . ." # if i3 doesn't install correctyl, do apt install i3-wm dunst i3lock i3status suckless-tools
    sudo apt install i3 
    sudo apt install compton hsetroot rxvt-unicode xsel rofi fonts-noto fonts-mplus xsettingsd lxappearance scrot viewnoir
    sudo apt install rofi
    # https://github.com/adi1090x/rofi.git -- source of rofi scripts
}

installQEMU(){
    sudo apt install qemu-kvm virt-manager virtinst libvirt-clients bridge-utils libvirt-daemon-system -y
    sudo systemctl enable --now libvirtd
    sudo systemctl start libvirtd
    sudo usermod -aG kvm $USER
    sudo usermod -aG libvirt $USER
}

installRegolithTwo(){
    echo "Installing Regolith2. . ."

    wget -qO - https://regolith-desktop.org/regolith.key | \
    gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null

    echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
        https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | \
        sudo tee /etc/apt/sources.list.d/regolith.list

    sudo apt update
    sudo apt install regolith-desktop regolith-compositor-picom-glx
    sudo apt upgrade
}

installGraphicalApps(){
    for f in ${!OSINFO[@]}
        do
            if [[ -f $f ]]; then
                echo "Package manager: ${OSINFO[$f]}"
                if [ ${OSINFO[$f]} == 'apt' ]; then
                    sudo apt update
                    sudo apt install discord
                    sudo apt install steam
                    installQEMU
                    installI3
                    installRegolithTwo

                elif [ ${OSINFO[$f]} == 'yum' ]; then
                    echo "Yum automated package install not setup yet."
                else
                    echo "Unrecognized package manager"
                fi
            fi
        done
}


linkDotFiles
installNeovim
installZ
# # installI3
packageManagerSpecficInstalls
installGraphicalApps

echo 'Finished.'
