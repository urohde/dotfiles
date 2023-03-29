#! /bin/bash

SCRIPT_DIR=$(pwd)
CONFIG_DIR=$HOME/.config

function link_directory() {
    [ ! -d $2 ] && ln -s $1 $2
}

# zsh
ln -s $SCRIPT_DIR/zshrc $HOME/.zshrc
ln -s $SCRIPT_DIR/p10k.zsh $HOME/.p10k.zsh

# i3
link_directory $SCRIPT_DIR/config/i3 $CONFIG_DIR/i3

# rofi
link_directory $SCRIPT_DIR/config/rofi $CONFIG_DIR/rofi

# nvim
link_directory $SCRIPT_DIR/config/nvim $CONFIG_DIR/nvim

# ranger
#sudo apt install ranger
link_directory $SCRIPT_DIR/config/ranger $CONFIG_DIR/ranger
#git clone https://github.com/alexanderjeurissen/ranger_devicons $CONFIG_DIR/ranger/plugins/ranger_devicons

# flameshot
link_directory $SCRIPT_DIR/config/flameshot $CONFIG_DIR/flameshot

# corsair keyboard rgb
link_directory $SCRIPT_DIR/config/ckb-next $CONFIG_DIR/ckb-next

