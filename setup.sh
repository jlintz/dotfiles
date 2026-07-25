#!/bin/bash
set -e

# pwd -P resolves symlinks without needing GNU readlink (greadlink on macOS)
REPO_DIR=$(cd "$(dirname "$0")" && pwd -P)

# Install oh-my-zsh (installer exits non-zero if already installed, so guard it)
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
fi

# -n: don't dereference an existing symlink to a directory (prevents creating
# links *inside* .zfunc when re-running setup)
ln -sfn "${REPO_DIR}/.gitconfig" "${HOME}/"
ln -sfn "${REPO_DIR}/.p10k.zsh" "${HOME}/"
ln -sfn "${REPO_DIR}/.zshrc" "${HOME}/"
ln -sfn "${REPO_DIR}/.zfunc" "${HOME}/"
ln -sfn "${REPO_DIR}/.aliases" "${HOME}/"
ln -sfn "${REPO_DIR}/.tmux.conf" "${HOME}/"

mkdir -p "${HOME}/.config"
ln -sfn "${REPO_DIR}/starship.toml" "${HOME}/.config/"

TMUX_PLUGIN_DIR="${HOME}/.tmux/plugins/"
if [ ! -d  "$TMUX_PLUGIN_DIR/tpm" ]; then
    mkdir -p "$TMUX_PLUGIN_DIR"
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
fi
