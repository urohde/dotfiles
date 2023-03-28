#! /bin/bash

SCRIPT_DIR=$(pwd)

function link_directory() {
    [ -d "$1/." ] || ln -s $1 $2
}

# zsh
ln -s $SCRIPT_DIR/zshrc $HOME/.zshrc
ln -s $SCRIPT_DIR/p10k.zsh $HOME/.p10k.zsh

# nvim
link_directory $SCRIPT_DIR/config/nvim $HOME/.config/nvim

# ranger
#sudo apt install ranger
link_directory $SCRIPT_DIR/config/ranger $HOME/.config/ranger
#git clone https://github.com/alexanderjeurissen/ranger_devicons $HOME/.config/ranger/plugins/ranger_devicons

# flameshot
link_directory $SCRIPT_DIR/config/flameshot $HOME/.config/flameshot

# corsair keyboard rgb
link_directory $SCRIPT_DIR/config/ckb-next $HOME/.config/ckb-next

