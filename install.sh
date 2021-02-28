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
### END OF SUBROUTINES ###


echo "Installing Updates n Stuff..."
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
install zsh
install tldr
install python3
install python3-pip
install zsh-syntax-highlighting

# symlinks called using subroutines
linkDotfile .vimrc
linkDotfile .tmux.conf
linkDotfile .zshrc

## neovim configs
sudo mkdir ~/.config/                        # creates nvim .config
sudo mkdir ~/.config/nvim/                   # creates nvim dir
sudo ln -s ~/.vimrc ~/.config/nvim/init.vim  # symlinks vimrc to neovim

# installs vim-plug manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo usermod -s /usr/bin/zsh $(whoami)  # sets the default terminal to zsh
