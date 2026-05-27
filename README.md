# Dotfiles

Personal dotfiles for macOS/Linux. Run `setup.sh` to install.

## Prerequisites

### Font

Install [MesloLGS NF Regular](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf) and set it as your terminal font.

### macOS packages

```bash
brew install fzf coreutils pyenv eza
```

### ZSH plugins

```bash
# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Dircolors solarized
git clone --recursive https://github.com/joel-porquet/zsh-dircolors-solarized \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-dircolors-solarized
```

## Install

```bash
./setup.sh
```

This will:
- Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) (keeps existing `.zshrc`)
- Symlink all dotfiles into `$HOME`
- Install [tmux plugin manager (tpm)](https://github.com/tmux-plugins/tpm)

## Post-install

After launching tmux, press `prefix + I` (Ctrl-a + I) to install tmux plugins.

To reconfigure the Powerlevel10k prompt at any time:

```bash
p10k configure
```
