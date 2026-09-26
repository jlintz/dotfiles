##  Speed up ZSH a bit
##
# use omz update
zstyle ':omz:update' mode disabled
# disable magic escaping on copy/pasting into terminal
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
## end speed ups
#
# Powerlevel10k is no longer in use - starship provides the prompt (see the
# bottom of this file). ~/.p10k.zsh is kept, and still symlinked by setup.sh,
# so switching back only means restoring the ZSH_THEME line below, the source
# line for ~/.p10k.zsh, and this instant-prompt block:
#
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
#ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
#
# macos specific configurations
if [[ `uname` == 'Darwin' ]]; then
    # Homebrew initialize
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # fzf lives under the Homebrew prefix, which differs between Apple Silicon
    # (/opt/homebrew) and Intel (/usr/local); brew shellenv exports the right
    # one. Must be set before oh-my-zsh sources the fzf plugin.
    export FZF_BASE="${HOMEBREW_PREFIX}/opt/fzf"

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

# Prefer neovim where it exists. Deliberately not set as git's core.editor so
# that git picks this up via $EDITOR and still falls back to vim elsewhere.
if (( $+commands[nvim] )); then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
export VISUAL=$EDITOR

# oh-my-zsh sets HISTSIZE=50000 but SAVEHIST=10000, so only a fifth of the
# in-memory history survives the session. Override after sourcing it.
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS

# Find Go binary
if [[ -d /usr/local/go/bin ]]; then
    export PATH="/usr/local/go/bin:$PATH"
fi

source ${HOME}/.aliases
[[ ! -f ~/.ts_zshrc ]] || source ${HOME}/.ts_zshrc
eval "$(starship init zsh)"
