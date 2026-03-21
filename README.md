* Install https://github.com/robbyrussell/oh-my-zsh
* Install https://github.com/powerline/fonts
* Install font: https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

# ZSH setup
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone --recursive git://github.com/joel-porquet/zsh-dircolors-solarized ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-dircolors-solarized

git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete


# MacOS
brew install fzf coreutils pyenv eza
