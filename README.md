# General

## If zsh not present
`zsh`

## Install oh my zsh
`sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

## Install powerline 10k
`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`

Set ZSH_THEME="powerlevel10k/powerlevel10k" in `~/.zshrc`.

`echo "source ~/.zshrc.pre-oh-my-zsh" >> ~/.zshrc`

## (Optional) if powerline 10k symbols are not showing, install fonts
Follow [this official guide](https://github.com/romkatv/powerlevel10k#fonts)

## Vim
`cp MyConfig/.vimrc ~/`

`pushd MyConfig`

`git submodule update --init`

`popd`

`cp -r MyConfigs/base16-vim/colors ~/.vim/colors`

for 256 color, check out [here](https://github.com/chriskempson/vim-tomorrow-theme/tree/master/colors)

## tmux

### If tmux not present
`brew install tmux`

### Copy over configurations

`cp MyConfig/.tmux.conf ~/`

if tmux version < 2.9, use `.tmux.conf.legacy`

on latest mac, hold `fn` key while selecting with mouse to copy

### Install tmux plugin manager

`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

### Install tmux plugins

Inside `tmux` session, enter `prefix + I`

This will install `tmux-resurrect`

## Node

Install from [official site](https://nodejs.org/en/download/)

## UV

Install from [official site](https://docs.astral.sh/uv/getting-started/installation/)

## [nvitop](https://github.com/XuehaiPan/nvitop)

`uvx nvitop`

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
On endpoint1: `cat ~/.ssh/*.pub`
On endpoint2: `echo <key> >> ~/.ssh/authorized_keys`
