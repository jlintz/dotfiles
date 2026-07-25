# Dotfiles

Personal dotfiles for macOS/Linux. Run `setup.sh` to install.

## Prerequisites

### Font

Install [Maple Mono NF](https://github.com/subframe7536/maple-font) and set it as your terminal font.

### macOS packages

```bash
brew install tmux fzf coreutils eza cmake starship
```

`cmake` is required to build the `tmux-mem-cpu-load` tmux plugin (compiled from source on first plugin install).

### Linux (Debian/Ubuntu) packages

```bash
sudo apt install zsh tmux fzf eza cmake build-essential wl-clipboard xsel starship
```

`wl-clipboard` provides `pbcopy`/`pbpaste` aliases on Wayland, `xsel` on X11. `eza` is in Debian 13+/Ubuntu 24.04+; on older releases plain `ls` is used automatically.

### ZSH plugins

```bash
# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Dircolors solarized
git clone --recursive https://github.com/joel-porquet/zsh-dircolors-solarized \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-dircolors-solarized
```

`zsh-syntax-highlighting` must stay last in the `plugins=()` array in `.zshrc` —
it wraps ZLE widgets at source time, so anything loaded after it goes
unhighlighted.

## Install

```bash
./setup.sh
```

This will:
- Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) (keeps existing `.zshrc`)
- Symlink all dotfiles into `$HOME`, backing up any pre-existing real file to `<name>.bak`
- Install [tmux plugin manager (tpm)](https://github.com/tmux-plugins/tpm) and the tmux plugins

## Prompt

The prompt is [starship](https://starship.rs), configured in `starship.toml`
(symlinked to `~/.config/starship.toml`) with the gruvbox dark palette.

Powerlevel10k was the previous prompt and is **no longer in use**. Its generated
config, `.p10k.zsh`, is kept in this repo and still symlinked to `$HOME` so the
switch back is easy. To go back:

1. Install the theme:

   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
     ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   ```

2. In `.zshrc`, uncomment the `ZSH_THEME` line and the instant-prompt block
   above it, re-add `[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh`, and drop the
   `starship init` line at the bottom. Run `p10k configure` to regenerate.

## Post-install

`setup.sh` installs the tmux plugins for you. This builds `tmux-mem-cpu-load`
(the mem/cpu readout on the right of the status bar) from source, so `cmake`
must be installed first (see [macOS packages](#macos-packages)). If the segment
is missing, verify the binary built:

```bash
~/.tmux/plugins/tmux-mem-cpu-load/tmux-mem-cpu-load --interval 2 --averages-count 0
```

If that errors, install `cmake` and re-run `./setup.sh` (or `prefix + I` inside tmux).
