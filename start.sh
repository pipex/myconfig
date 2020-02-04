#!/bin/sh -e
echo "Installing base requirements"
echo "* Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "* git"
brew install git

echo "* downloading configuration"
git clone https://github.com/pipex/myconfig.git ~/.myconfig

echo "DONE"
echo "Installing everything else"
cd ~/.myconfig && make install
