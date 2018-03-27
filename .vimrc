" Theme
colorscheme Tomorrow-Night

" General
let mapleader="\""
set number
set showcmd
set cursorline
set undolevels=1000

filetype indent on
syntax on

" Folding
set tabstop=4
set softtabstop=4
set smartindent
set autoindent

" Searching
set showmatch " highlight matching [{()}]
set incsearch " search as characters are entered
set hlsearch " highlight matches
nnoremap <Esc><Esc> :nohlsearch<CR>

" Folding
set foldenable
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max
	" space open/closes folds
nnoremap <S-o> za 
set foldmethod=indent " fold based on indent level

" Movement
	" move vertically by visual line
nnoremap j gj
nnoremap k gk
	" move to beginning/end of line
nnoremap B ^
nnoremap E $
	" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
	" highlight last inserted text
nnoremap gV `[v`]

" Leader Shortcuts
inoremap jk <esc>
