##############################################
# System configuration
##############################################

PYTHON_VERSION ?= 3.7.6
NODE_VERSION ?= lts/dubnium


##############################################
# Paths
##############################################

BIN=/usr/local/bin
APPS=/Applications
CONFIG=~/.myconfig

##############################################
# Bootstrap
##############################################

# Install Homebrew
$(BIN)/brew: 
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install git
$(BIN)/git:
	brew install git

# Download config
$(CONFIG): $(BIN)/git
	echo "Not yet implemented"

.PHONY: fonts
fonts: | $(CONFIG)
	cp $(CONFIG)/fonts/*.otf /Library/Fonts

.PHONY: shell
shell: | $(CONFIG)
	# Install oh-my-zsh
	sh -c "$$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
		ln -sf $(CONFIG)/zsh/zshrc ~/.zshrc && \
		ln -sf $(CONFIG)/zsh ~/.zsh

.PHONY: bootstrap
bootstrap: fonts shell


##############################################
# Command line
##############################################

$(BIN)/pyenv: $(BIN)/brew
	brew install pyenv

.PHONY: python
python: ~/.pyenv/versions/$(PYTHON_VERSION)/bin/python
~/.pyenv/versions/$(PYTHON_VERSION)/bin/python: $(BIN)/brew $(BIN)/pyenv
	PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install $(PYTHON_VERSION)
	eval "$$(pyenv init -)" && pyenv global $(PYTHON_VERSION) && pip install --upgrade pip

.PHONY: rust
rust:
	curl -sf -L https://static.rust-lang.org/rustup.sh | sh
	
~/.vimrc: $(CONFIG) 
	ln -sf $(CONFIG)/vim/vimrc ~/.vimrc
	ln -sf $(CONFIG)/vim/vimrc.local ~/.vimrc.local
	ln -sf $(CONFIG)/vim/vimrc.local.bundles ~/.vimrc.local.bundles
	mkdir -p ~/.config/nvim
	ln -sf $(CONFIG)/vim/nvim-init.vim ~/.config/nvim/init.vim
	ln -sf $(CONFIG)/vim/coc-settings.json ~/.config/nvim/coc-settings.json

# Install fzf and rg as vim dependencies
$(BIN)/fzf: $(BIN)/brew
	brew install fzf

$(BIN)/rg: $(BIN)/brew
	brew install ripgrep

$(BIN)/ccls: $(BIN)/brew
	brew install ccls

$(BIN)/ctags: $(BIN)/brew
	brew install ctags

# Vim
.PHONY: vim
vim: $(BIN)/nvim
$(BIN)/nvim: ~/.vimrc $(BIN)/fzf $(BIN)/rg $(BIN)/ccls $(BIN)/ctags
	brew install neovim
	eval "$$(pyenv init -)" && \
		pip install --upgrade neovim && \
		nvim -c ":PlugInstall" -c ":q" -c ":q"

# Autojump
.PHONY: j
j: $(BIN)/j
$(BIN)/j: $(BIN)/brew
	brew install autojump

.PHONY: jq
jq: $(BIN)/jq
$(BIN)/jq: $(BIN)/brew
	brew install jq

.PHONY: yq
jq: $(BIN)/yq
$(BIN)/yq: $(BIN)/brew
	brew install yq

# Tmux
.PHONY: tmux
tmux: $(BIN)/tmux
$(BIN)/tmux: $(BIN)/brew | $(CONFIG)
	# Install version 2.9a_1
	brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/c2a5cd21a94f5574458e16198f2c4a1b7a93a0c9/Formula/tmux.rb && brew pin tmux
	git clone https://github.com/samoshkin/tmux-config.git
	./tmux-config/install.sh
	ln -sf $(CONFIG)/tmux/tmux.conf ~/.tmux.conf
	rm -rf ./tmux-config

# NVM and Node
.PHONY: node
node: $(BIN)/nvm
$(BIN)/nvm: $(BIN)/brew
	brew install nvm
	source $(CONFIG)/zsh/02-nvm && \
		nvm install $(NODE_VERSION) && \
		npm install -g yarn

# Vagrant
.PHONY: vagrant
vagrant: $(BIN)/vagrant
$(BIN)/vagrant: $(BIN)/brew virtualbox
	brew cask install vagrant

# Docker
.PHONY: install-docker
install-docker: $(BIN)/docker
$(BIN)/docker: $(BIN)/brew virtualbox
	brew install docker-machine docker
	brew services start docker-machine

.PHONY: todo
todo: $(BIN)/todo.sh
$(BIN)/todo.sh: $(BIN)/brew
	brew install todo-txt
	ln -sf $(CONFIG)/todo.cfg ~/.todo.cfg

.PHONY: install-commands
install-commands: python node rust vim tmux j jq yq todo


##############################################
# Must have applications
##############################################

# iTerm2
$(APPS)/iTerm.app: | $(BIN)/brew
	brew cask install iterm2

# Bitwarden
$(APPS)/Bitwarden.app: | $(BIN)/brew
	brew cask install bitwarden

# Firefox
$(APPS)/Firefox.app: | $(BIN)/brew
	brew cask install firefox

# Magnet
$(APPS)/Magnet.app: | $(BIN)/brew
	echo "Not implemented yet. Install Magnet using APP store"

$(APPS)/Spotify.app: | $(BIN)/brew
	brew cask install spotify

$(APPS)/AppCleaner.app: | $(BIN)/brew
	brew cask install appcleaner

$(APPS)/The\ Unarchiver.app: | $(BIN)/brew
	brew cask install the-unarchiver

# VirtualBox
.PHONY: virtualbox
virtualbox: $(APPS)/VirtualBox.app
$(APPS)/VirtualBox.app: | $(BIN)/brew
	brew cask install virtualbox

.PHONY: install-apps
install-apps: $(APPS)/Bitwarden.app $(APPS)/iTerm.app $(APPS)/Firefox.app $(APPS)/Spotify.app $(APPS)/AppCleaner.app $(APPS)/The\ Unarchiver.app


##############################################
# Install everything
##############################################

.PHONY: install
install: bootstrap install-commands install-apps


.DEFAULT: install

