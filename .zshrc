##  Speed up ZSH a bit
##
# use omz update
DISABLE_AUTO_UPDATE="true"
# disable magic escaping on copy/pasting into terminal
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
#
# Smarter completion initialization
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

## end speed ups
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Handle fzf on MacOS
if [[ `uname` == "Darwin" ]]; then
    export FZF_BASE="/opt/homebrew/opt/fzf/"
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
#
# macos specific configurations
if [[ `uname` == 'Darwin' ]]; then
    # Homebrew initialize
    export CPATH=/opt/homebrew/include
    export LIBRARY_PATH=/opt/homebrew/lib
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # for https://github.com/maxgoedjen/secretive
    SOCKET=/Users/$USER/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    if [[ -e $SOCKET ]]; then
        export SSH_AUTH_SOCK=${SOCKET}
    fi
fi
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export ZSH="${HOME}/.oh-my-zsh"
plugins=(git
pip
pipenv
brew
github
pyenv
sudo
zsh-syntax-highlighting
zsh-autocomplete
docker
vi-mode
fzf
zsh-dircolors-solarized
tmux
virtualenv
uv
)

source $ZSH/oh-my-zsh.sh

# enable vi mode
bindkey -v
bindkey -M viins '\e.' insert-last-word
bindkey -M viins '\C-l.' clear-screen
bindkey -M viins '\C-a.' beginning-of-line
bindkey -M viins '\C-e.' end-of-line
bindkey -M viins '\C-w.' backward-kill-word

export PATH="$HOME/.local/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Find Go binary
export PATH="/usr/local/go/bin:$PATH"

source ${HOME}/.aliases
