#!/bin/bash

# install vim
sudo apt install vim -y

# copy over .vimrc
cp .vimrc /home/$(whoami)/.vimrc

source /home/$(whoami)/.vimrc

# install node.js for coc.nvim
sudo curl -sL install-node.now.sh/lts > node.sh
chmod +x node.sh
./node.sh

# install plugins
vim +'PlugInstall --sync' +qa
