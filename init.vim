set background=dark
set number
set relativenumber
set showmatch
syntax enable
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set laststatus=2

call plug#begin('~/.config/nvim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

call plug#end()

" Automatically format Rust code on save
let g:rustfmt_autosave = 1

" Status line config with lightline
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }
