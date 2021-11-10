# Steps

## If zsh not present
`brew install zsh`

`zsh`

## Install oh my zsh
`sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

## Install powerline 10k
`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`

Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc.

## (Optional) if powerline 10k symbols are not showing, install fonts
Follow [this official guide](https://github.com/romkatv/powerlevel10k#fonts)

## Vim
`cp MyConfig/.vimrc ~/`

`git submodule update --init`

`cp MyConfig/base-16-color/\*.vim ~/.vim/color/`

for 256 color, check out [here](https://github.com/chriskempson/vim-tomorrow-theme/tree/master/colors)

## tmux
`cp MyConfig/.tmux.conf ~/`

if tmux version < 2.9, use `.tmux.conf.legacy`

on latest mac, hold `fn` key while selecting with mouse to copy

## Rectangle
`brew install --cask rectangle`

# SSH
vi ~/.ssh/authorized_keys
copy finger print over
