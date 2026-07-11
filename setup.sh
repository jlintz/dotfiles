#!/bin/bash
set -e

if [[ $(uname) == "Darwin" ]]; then
    READLINK=greadlink
    OS="mac"
elif [[ $(uname) == "Linux" ]]; then
    READLINK=readlink
    OS="linux"
else
    echo "Unsupported OS: $(uname)" >&2
    exit 1
fi

REPO_DIR=$(dirname "$($READLINK -f "${0}")")

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended

# -n: don't dereference an existing symlink to a directory (prevents creating
# links *inside* .zfunc when re-running setup)
ln -sfn ${REPO_DIR}/.gitconfig ${HOME}/
ln -sfn ${REPO_DIR}/.p10k.zsh ${HOME}/
ln -sfn ${REPO_DIR}/.zshrc ${HOME}/
ln -sfn ${REPO_DIR}/.zfunc ${HOME}/
ln -sfn ${REPO_DIR}/.aliases ${HOME}/
ln -sfn ${REPO_DIR}/.tmux.conf ${HOME}/

TMUX_PLUGIN_DIR="${HOME}/.tmux/plugins/"
if [ ! -d  "$TMUX_PLUGIN_DIR/tpm" ]; then
    mkdir -p "$TMUX_PLUGIN_DIR"
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
fi
