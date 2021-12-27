echo "Make sure you're running this as the correct user you want to install the files on.  Note: If you run this with sudo, it will replace root User files."
echo "To update current user files just run: ./setup.sh"

echo "Updating files for $(whoami).  Continue?(y/n)"
read answer

#If answer y or Y then continue else stop
[ "${answer}" == 'y' ] || [ "${answer}" == 'Y' ] && echo "Replacing files in home dir for user $(whoami) . . ." || echo "Quiting . . ." ; exit

rm ~/.bash_aliases
rm ~/.bashrc
rm ~/.profile
rm ~/.vimrc

ln -rs bash_aliases ~/.bash_aliases
ln -rs bashrc ~/.bashrc
ln -rs profile ~/.profile
ln -rs vimrc ~/.vimrc


echo 'Finished.'
