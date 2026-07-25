##  Speed up ZSH a bit
##
# use omz update
zstyle ':omz:update' mode disabled
# disable magic escaping on copy/pasting into terminal
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
## end speed ups
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

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
#ZSH_THEME="powerlevel10k/powerlevel10k"

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
    SOCKET=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    if [[ -e $SOCKET ]]; then
        export SSH_AUTH_SOCK=${SOCKET}
    fi
fi

export ZSH="${HOME}/.oh-my-zsh"

# custom completion functions
fpath=(~/.zfunc $fpath)

plugins=(git
brew
sudo
docker
vi-mode
fzf
zsh-dircolors-solarized
tmux
uv
# zsh-syntax-highlighting wraps ZLE widgets at source time, so it must stay
# last - anything loaded after it won't be highlighted.
zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# vi mode is enabled by the vi-mode plugin; restore some emacs-style
# bindings in insert mode
bindkey -M viins '\e.' insert-last-word
bindkey -M viins '\C-l' clear-screen
bindkey -M viins '\C-a' beginning-of-line
bindkey -M viins '\C-e' end-of-line
bindkey -M viins '\C-w' backward-kill-word

export PATH="$HOME/.local/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Find Go binary
if [[ -d /usr/local/go/bin ]]; then
    export PATH="/usr/local/go/bin:$PATH"
fi

source ${HOME}/.aliases
[[ ! -f ~/.ts_zshrc ]] ||source ${HOME}/.ts_zshrc
eval "$(starship init zsh)"
