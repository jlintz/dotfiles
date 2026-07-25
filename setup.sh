#!/bin/bash
set -e

# pwd -P resolves symlinks without needing GNU readlink (greadlink on macOS)
REPO_DIR=$(cd "$(dirname "$0")" && pwd -P)

# Install oh-my-zsh (installer exits non-zero if already installed, so guard it)
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
fi

# Symlink SRC to DEST, moving any pre-existing real file or directory aside to
# <dest>.bak first so a first run on a machine can't silently eat local config.
# -n: don't dereference an existing symlink to a directory (prevents creating
# links *inside* .zfunc when re-running setup)
link() {
    local src="$1" dest="$2"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "backing up existing $dest -> $dest.bak"
        mv "$dest" "$dest.bak"
    fi
    ln -sfn "$src" "$dest"
}

link "${REPO_DIR}/.gitconfig" "${HOME}/.gitconfig"
# p10k is not the active prompt (starship is), but keep the config linked so
# switching back is just a .zshrc edit
link "${REPO_DIR}/.p10k.zsh" "${HOME}/.p10k.zsh"
link "${REPO_DIR}/.zshrc" "${HOME}/.zshrc"
link "${REPO_DIR}/.zfunc" "${HOME}/.zfunc"
link "${REPO_DIR}/.aliases" "${HOME}/.aliases"
link "${REPO_DIR}/.tmux.conf" "${HOME}/.tmux.conf"

mkdir -p "${HOME}/.config"
link "${REPO_DIR}/starship.toml" "${HOME}/.config/starship.toml"

TMUX_PLUGIN_DIR="${HOME}/.tmux/plugins"
if [ ! -d "$TMUX_PLUGIN_DIR/tpm" ]; then
    mkdir -p "$TMUX_PLUGIN_DIR"
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
fi

# Install/update the tmux plugins so `prefix + I` isn't needed on a fresh box.
# Builds tmux-mem-cpu-load from source, so cmake must be installed.
"$TMUX_PLUGIN_DIR/tpm/bin/install_plugins"
