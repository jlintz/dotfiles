# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal dotfiles repository for macOS/Linux shell configuration. Files are symlinked into `$HOME` via `setup.sh`.

## Setup

```bash
./setup.sh  # installs oh-my-zsh, symlinks all dotfiles to $HOME
```

Prerequisites listed in README.md: oh-my-zsh, MesloLGS NF font, plus `brew install tmux fzf coreutils eza cmake` on macOS or the apt equivalents on Debian/Ubuntu.

## Architecture

- **`.zshrc`** — Main shell config. Uses oh-my-zsh with powerlevel10k theme, vi-mode, and numerous plugins. Has macOS-specific blocks (Homebrew, Secretive SSH agent). Adds `~/.zfunc` to `fpath` for custom completions.
- **`.aliases`** — Shell aliases and functions. eza-wrapping `ls` function on any platform where eza is installed (gls fallback on macOS), wl-copy/xsel clipboard aliases on Linux, nvim→vim alias. Contains `transcode_ac3()` ffmpeg helper.
- **`.gitconfig`** — Git config with custom aliases (`rb` for pull-rebase, `pb` for push-upstream, `ll`/`ls`/`ld` for log formats, `la` to list aliases).
- **`.tmux.conf`** — tmux config. Leader remapped to `C-a`. Pane splits with `|`/`-`. Vi copy-mode bindings. Seamless vim/tmux pane navigation via `C-h/j/k/l`.
- **`.p10k.zsh`** — Powerlevel10k prompt configuration (generated, rarely hand-edited).
- **`setup.sh`** — Symlink installer. Detects macOS vs Linux for `readlink`/`greadlink`.
- **`iterm.json`** — iTerm2 profile export.

## Key Patterns

- Platform detection uses `uname` checks (`Darwin` vs `Linux`) throughout `.zshrc` and `.aliases`.
- All dotfiles are symlinked (not copied), so edits here are live immediately.
- Shell plugins are managed via oh-my-zsh's plugin system in `.zshrc`'s `plugins=()` array.
