# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git alias-tips)

source $ZSH/oh-my-zsh.sh

RANGER_LOAD_DEFAULT_RC=false
export EDITOR=nvim

#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

eval "$(zoxide init zsh)"

APPEND_HISTORY="true"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#export PATH=$PATH:/usr/local/go/bin
#[[ -s "/home/ulrik/.gvm/scripts/gvm" ]] && source "/home/ulrik/.gvm/scripts/gvm"

# pnpm
#export PNPM_HOME="/home/ulrik/.local/share/pnpm"
#export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Created by `pipx` on 2023-03-15 09:12:12
#export PATH="$PATH:/home/ulrik/.local/bin"

fpath+=${ZDOTDIR:-~}/.zsh_functions
