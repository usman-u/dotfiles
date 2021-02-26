" wraps lines
set wrap

" makes tabs 4 spaces
set tabstop=4 softtabstop=4
set shiftwidth=4

set scrolloff=9

" shows line numbers
set number

" allows copying without numbers
se mouse+=a


set smartindent

set ignorecase
set smartcase

set paste

set clipboard=unnamedplus

call plug#begin('~/dotfiles/plugins/vim_plugins')
Plug 'valloric/youcompleteme'
call plug#end()
