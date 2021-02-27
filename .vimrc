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

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'jiangmiao/auto-pairs'

call plug#end()

let g:rustfmt_autosave = 1
