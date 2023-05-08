
echo "Installing Unity"
sudo apt install dotnet-sdk-6.0


addKey(){
    # Manually adds key if it is not recognized 
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BE3E6EA534E8243F
    wget -o- https://hub.unity3d.com/linux/keys/public
    file public

    gpg --no-default-keyring --keyring ./unity_keyring.gpg --import public
    gpg --no-default-keyring --keyring ./unity_keyring.gpg --export > ./unity-archive-keyring.gpg

    sudo mv ./unity-archive-keyring.gpg /etc/apt/trusted.gpg.d/
    sudo apt update
    sudo apt-get install unityhub
}

standardInstall(){
    wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
    sudo sh -c 'echo "deb [signedby=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
    sudo apt update
    sudo apt install unity-hub
}

standardInstall
echo "If install fails then use the addKey function in this script."