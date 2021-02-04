#!/bin/bash

echo "Installing Updates n Stuff..."


# main update
sudo apt update 
sudo apt upgrade -y --allow-downgrades

# subroutine for installing
function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already Installed: ${1}"
  fi
}

# main things
install vim 
install htop
install tmux
install nmap
install curl
install git
install neofetch

# extra things
install figlet
install lolcat


# Ookla Speed Test CLI
install gnupg1 
install apt-transport-https 
install dirmngr
export INSTALL_KEY=379CE192D401AB61
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
echo "deb https://ookla.bintray.com/debian generic main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
sudo apt-get update
install speedtest








# subroutine for symlinks
dotfilesDir=$(pwd)

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ~/${1} ]; then
    # Existing symlink 
    echo "Removing existing symlink: ${dest}"
    rm ${dest} 

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
}


# acutual symlinks
linkDotfile .vimrc
linkDotfile .tmux.conf
linkDotfile .bashrc


source ~/.bashrc

figlet "... Done" | lolcat


