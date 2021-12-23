#!/bin/bash

echo -n "Enter Ubuntu or Centos: "
read VAR

if [[ $VAR == "Ubuntu" ]]
then

    cd ~
    apt -y update && apt -y upgrade
    apt -y install git vim net-tools zsh  wget unzip
    wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh 
    yes | install.sh 
    chsh -s $(which zsh)
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    sed -i 's/plugins=(git)/ plugins=( git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc \
    echo "ENABLE_CORRECTION=”true”" >> ~/.zshrc
    zsh

    # install ohmyposh
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    chmod +x /usr/local/bin/oh-my-posh
    mkdir ~/.poshthemes
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
    unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
    chmod u+rw ~/.poshthemes/*.json
    rm ~/.poshthemes/themes.zip
    echo  ' eval "$(oh-my-posh --init --shell zsh --config  /root/.poshthemes/night-owl.omp.json)" '

elif [[ $VAR == "Centos" ]]
then
    cd ~
    dnf -y update && dnf -y upgrade
    dnf -y install git vim net-tools zsh  wget unzip
    wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    yes | bash install.sh
    rm -rf install.sh
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    chsh -s $(which zsh)
    sed -i 's/plugins=(git)/ plugins=( git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc \
    echo "ENABLE_CORRECTION=”true”" >> ~/.zshrc
    zsh

    # install ohmyposh
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    chmod +x /usr/local/bin/oh-my-posh
    mkdir ~/.poshthemes
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
    unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
    chmod u+rw ~/.poshthemes/*.json
    rm ~/.poshthemes/themes.zip
    echo  ' eval "$(oh-my-posh --init --shell zsh --config  /root/.poshthemes/night-owl.omp.json)" '

else
  echo "Enter Ubuntu or Centos only!"
fi
