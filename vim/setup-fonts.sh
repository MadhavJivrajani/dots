#!/bin/bash

mkdir -p ~/.local/share/fonts

cd ~/.local/share/fonts 

# download the fonts
curl -fLo "Droid Sans Mono Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf

curl -fLo "Droid Sans Mono Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf

# set the font
sudo setfont Droid\ Sans\ Mono\ Nerd\ Font\ Complete\ Mono.otf
