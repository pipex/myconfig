#!/bin/sh

echo "Installing homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Instaling git"
brew install git

# TODO: download config and run makefile
