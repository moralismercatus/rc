#!/bin/sh

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

