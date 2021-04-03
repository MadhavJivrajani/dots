#!/bin/bash

# install vim
sudo apt install vim -y

# install vim-plug
curl -fLo /home/$(whoami)/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy over .vimrc
cp .vimrc /home/$(whoami)/.vimrc

# install plugins
vim +'PlugInstall --sync' +qa
