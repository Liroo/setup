#!/bin/bash

# Load color
source ./colors.sh

# Be sure that the user is root
(( EUID != 0 )) && exec sudo -- "$0" "$@"
if ((EUID != 0))
then
  red "You must be root in order to run the setup script"
  exit
fi

green "You are root!"

# basics
green "installing zsh, git, emacs..."
sudo apt-get install zsh git emacs openssh-server

# ohmyzsh
green "installing ohmyzsh..."
0>/dev/null sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# nodejs
green "installing nodejs..."
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs

# yarn
green "installing yarn..."
curl -o- -L https://yarnpkg.com/install.sh

# google chrome
green "installing google chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# emacs rc
green "configuring emacs..."
cat dot.emacs >> ~/.emacs
cp dot.myemacs ~/.myemacs

# zsh rc
green "configuring zsh and ohmyzsh..."
cat dot.zshrc >> ~/.zshrc

green "That's all, folks!"