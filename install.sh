#!/bin/bash

### MAIN SUBROUTINES ###

# Install Subroutine
function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1 
  else
    echo "Already Installed: ${1}"
  fi
}

# Symbolic links Subroutine
dotfilesDir=$(pwd)

function linkDotfile {
  dest="${HOME}/${1}"

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
### END OF SUBROUTINES ###

echo "Running 'apt update'"
sudo apt update

printf "\nRunning 'apt upgrade'\n"
sudo apt upgrade -y

# main programs installed via subroutine call
install net-tools
install vim 
install neovim 
install htop
install tmux
install nmap
install curl
install git
install neofetch
install tldr
install python3
install python3-pip
install iftop

# symlinks called using subroutines
printf "\n"
linkDotfile .vimrc
linkDotfile .tmux.conf
linkDotfile .zshrc

## neovim configs
sudo mkdir ~/.config/ >/dev/null 2>&1                        # creates nvim .config  
sudo mkdir ~/.config/nvim/ >/dev/null 2>&1                   # creates nvim dir
sudo ln -s ~/.vimrc ~/.config/nvim/init.vim >/dev/null 2>&1  # symlinks vimrc to neovim

echo "Setting default terminal to bash"
sudo usermod -s /usr/bin/bash $(whoami)  >/dev/null 2>&1 # sets the default terminal to zsh

printf "\nRerun script as sudo if you want the root user to have the same modifications\n"