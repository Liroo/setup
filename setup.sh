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
sudo apt install software-properties-common apt-transport-https wget
sudo apt-get install -y zsh git emacs openssh-server curl

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

# visual studio code
green "installing visual studio code..."
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code

# terminator
green "installing terminator..."
sudo add-apt-repository ppa:gnome-terminator -y
sudo apt-get update
sudo apt-get install -y terminator

# google chrome
green "installing google chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# emacs rc
green "configuring emacs..."
cat dot.emacs >> ~/.emacs
cp dot.myemacs ~/.myemacs

# zsh rc
green "configuring zsh and ohmyzsh..."
cat dot.zshrc >> ~/.zshrc

green "That's all, folks!"