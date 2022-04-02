#!/bin/bash

git clone https://github.com/adi1091x/rofi.git ~/Downloads/rofi
git clone https://https://github.com/addy-dclxvi/i3-starterpack.git ~/Downloads/i3-starterpack


echo "Installing rofi and i3-starterpack"
mkdir -p ~/.fonts
sudo mv -v ~/Downloads/i3-starterpack/.fonts/* ~/.fonts/


mkdir -p ~/.i3
sudo mv -v ~/Downloads/i3-starterpack/.config/* ~/.config/


# ROFI
sudo chmod +x ~/Downloads/rofi/setup.sh
sudo ./Downloads/rofi/setup.sh

sudo cp -r ./rofi ~/.config/rofi
sudo cp -r ./i3 ~/.config/i3




echo "Cleaning up..."
rm -rf ~/Downloads/i3-starterpack
rm -rf ~/Downloads/rofi

