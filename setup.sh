#!/bin/bash
set +eox

if [[ $(uname) == "Darwin" ]]; then
    READLINK=greadlink
    OS="mac"
elif [[ $(uname) == "Linux" ]]; then
    READLINK=readlink
    OS="linux"
fi

REPO_DIR=$(dirname "$($READLINK -f "${0}")")

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended

ln -sf ${REPO_DIR}/.gitconfig ${HOME}/
ln -sf ${REPO_DIR}/.p10k.zsh ${HOME}/
ln -sf ${REPO_DIR}/.zshrc ${HOME}/
ln -sf ${REPO_DIR}/.zfunc ${HOME}/
ln -sf ${REPO_DIR}/.aliases ${HOME}/
ln -sf ${REPO_DIR}/.tmux.conf ${HOME}/

TMUX_PLUGIN_DIR="${HOME}/.tmux/plugins/"
if [ ! -d  "$TMUX_PLUGIN_DIR/tpm" ]; then
    mkdir -p "$TMUX_PLUGIN_DIR"
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
fi
