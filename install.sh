#! /bin/bash

SCRIPT_DIR=$(pwd)
CONFIG_DIR=$HOME/.config

INSTALL=false
UBUNTU=false

while getopts 'iu' OPTION; do 
  case "$OPTION" in 
    u)
      UBUNTU=true
      ;;
    i)
      INSTALL=true
  esac
done

function link_directory() {
    [ ! -d $2 ] && ln -s $1 $2
}

# dependencies
if $INSTALL
then
  if $UBUNTU
  then
    sudo apt install build-essential
    sudo apt install git
    sudo apt install curl
  fi
fi

# zsh
ln -s $SCRIPT_DIR/zshrc $HOME/.zshrc
ln -s $SCRIPT_DIR/p10k.zsh $HOME/.p10k.zsh
ln -s $SCRIPT_DIR/oh-my-zsh/alias.zsh $HOME/.oh-my-zsh/custom/alias.zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# fzf
if $INSTALL
then
  if $UBUNTU
  then
    sudo apt install fzf
  fi
fi

# exa
if $INSTALL 
then
  if $UBUNTU 
  then
    sudo apt install exa
  fi
fi

# zoxide
if $INSTALL
then
  if $UBUNTU 
  then
    sudo apt install zoxide
  fi
fi

# nvim
if $INSTALL
then
  if $UBUNTU
  then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage\nchmod u+x nvim.appimage\n./nvim.appimage
    ./nvim.appimage --appimage-extract                                                                                               TSTP ✘  40s    19:12:04 
    ./squashfs-root/AppRun --version              
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
  fi
fi

# lvim
ln -s $SCRIPT_DIR/config/lvim/config.lua $CONFIG_DIR/lvim/config.lua

if $INSTALL
then
  LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
fi


# ranger
if $INSTALL 
then
  if $UBUNTU
  then
    sudo apt install ranger
  fi
  git clone https://github.com/alexanderjeurissen/ranger_devicons $CONFIG_DIR/ranger/plugins/ranger_devicons
fi

link_directory $SCRIPT_DIR/config/ranger $CONFIG_DIR/ranger

# flameshot
link_directory $SCRIPT_DIR/config/flameshot $CONFIG_DIR/flameshot

# corsair keyboard rgb
link_directory $SCRIPT_DIR/config/ckb-next $CONFIG_DIR/ckb-next

# alacritty
link_directory $SCRIPT_DIR/config/alacritty $CONFIG_DIR/alacritty

# qtile
link_directory $SCRIPT_DIR/config/qtile $CONFIG_DIR/qtile

if $INSTALL 
then
  pip install xcffib
  pip install qtile
  if $UBUNTU
  then
    sudo cp $SCRIPT_DIR/qtile.desktop /usr/share/xsessions/qtile.desktop
  fi
fi

# rofi
link_directory $SCRIPT_DIR/config/rofi $CONFIG_DIR/rofi

if $INSTALL
then
  if $UBUNTU
  then
    sudo apt install rofi
  fi
fi

# betterlockscreen
ln -s $SCRIPT_DIR/config/betterlockscreen/betterlockscreenrc $CONFIG_DIR/betterlockscreen/betterlockscreenrc

# dunst
link_directory $SCRIPT_DIR/config/dunst $CONFIG_DIR/dunst

