#!/bin/sh

###############################################################################
# Install dependencies
###############################################################################
sudo apt-get install \
	git \
	silversearcher-ag

###############################################################################
# Copy config files to proper locations.
###############################################################################
cp \
	.inputrc \
	.vimrc \
	.tmux.conf \
	~/

###############################################################################
# Install Vundle vim plugin system and install plugins.
###############################################################################
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
vim +PluginUpdate +qall

###############################################################################
# Install tmux plugin system and install plugins.
###############################################################################
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins
~/.tmux/plugins/tpm/bin/update_plugins all
# Note: if plugins still unresponsive: _ctrl+a, I_ to install plugins manually.

###############################################################################
# Append shell config.
###############################################################################
echo '# Configurations from rc/install.sh:' | tee -a ~/.bashrc

# tmux -2 forces tmux to use screen-256color, so e.g. highlighting works.
echo alias tmux=\'tmux -2\' | tee -a ~/.bashrc

echo !!!RC Installation Completed!!!
echo !!!Restart or \'source\' Shell!!!

###############################################################################
# Set up Neovim config.
###############################################################################
mkdir -p ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

