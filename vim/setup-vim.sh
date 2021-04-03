#!/bin/bash

# install vim
sudo apt install vim -y

# install vim-plug
curl -fLo /home/$(whoami)/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy over .vimrc
cp .vimrc /home/$(whoami)/.vimrc

# install node for coc.nvim
sudo curl -sL install-node.now.sh/lts > node.sh
chmod +x node.sh
./node.sh

# install plugins
vim +'PlugInstall --sync' +qa
