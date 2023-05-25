
echo "Installing Unity"
sudo apt update
sudo apt install dotnet-sdk-6.0

installMono(){
  # Mono-develop WITH msbuild tools is required for unity LSP in vscode.
  # - Make sure to set useModernNet to false in vscode and mono-develop is installed.
  sudo apt install ca-certificates gnupg
  sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
  sudo apt update
  sudo apt install mono-devel
}

addKeyManually(){
  # Manually adds key if it is not recognized 
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BE3E6EA534E8243F
  wget -o- https://hub.unity3d.com/linux/keys/public
  file public

  gpg --no-default-keyring --keyring ./unity_keyring.gpg --import public
  gpg --no-default-keyring --keyring ./unity_keyring.gpg --export > ./unity-archive-keyring.gpg

  sudo mv ./unity-archive-keyring.gpg /etc/apt/trusted.gpg.d/
  sudo apt update
  sudo apt-get install unityhub

  # Cleanup
  rm public
  rm unity_keyring_*

}

standardInstall(){
  wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
  sudo sh -c 'echo "deb [signedby=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
  sudo apt update
  sudo apt install unityhub
}

installMono
#standardInstall || addKeyManually
echo "If install fails then use the addKey function in this script."
