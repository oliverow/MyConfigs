# Terminal

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

`pushd MyConfig`
`git submodule update --init`
`popd`

`cp MyConfig/base-16-color/\*.vim ~/.vim/colors/`

for 256 color, check out [here](https://github.com/chriskempson/vim-tomorrow-theme/tree/master/colors)

## tmux
`cp MyConfig/.tmux.conf ~/`

if tmux version < 2.9, use `.tmux.conf.legacy`

on latest mac, hold `fn` key while selecting with mouse to copy

## [fzf](https://github.com/junegunn/fzf)
`brew install fzf`

`$(brew --prefix)/opt/fzf/install`

Then add the following to `zshrc`

```
## fzf setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='--'
```

## [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
Follow the installation instruction from [here](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)


# Mac

## Rectangle
`brew install --cask rectangle`

# SSH
vi ~/.ssh/authorized_keys
copy finger print over
