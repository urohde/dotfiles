#! /bin/bash

SCRIPT_DIR=$(pwd)

# zsh
ln -s $SCRIPT_DIR/zshrc $HOME/.zshrc
ln -s $SCRIPT_DIR/p10k.zsh $HOME/.p10k.zsh

# nvim
ln -s $SCRIPT_DIR/config/nvim $HOME/.config/nvim

# ranger
#sudo apt install ranger
ln -s $SCRIPT_DIR/config/ranger $HOME/.config/ranger
#git clone https://github.com/alexanderjeurissen/ranger_devicons $HOME/.config/ranger/plugins/ranger_devicons

# flameshot
ln -s $SCRIPT_DIR/config/flameshot $HOME/.config/flameshot
