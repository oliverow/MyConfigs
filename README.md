# Steps
## Vim
`cp MyConfig/.vimrc ~/`

`git submodule update --init`

`cp MyConfig/base-16-color/\*.vim ~/.vim/color/`

for 256 color, check out [here](https://github.com/chriskempson/vim-tomorrow-theme/tree/master/colors)

## tmux
`cp MyConfig/.tmux.conf ~/`

if tmux version < 2.9, use `.tmux.conf.legacy`

# SSH
vi ~/.ssh/authorized_keys
copy finger print over
