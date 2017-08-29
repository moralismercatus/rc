" #############################################################################
" ### Plugins Settings (must go first) 
" #############################################################################
 
set nocompatible              " required
filetype off                  " required

" Required for Vundle:
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Add all plugins here
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'othree/xml.vim'
"Plugin 'Valloric/YouCompleteMe' ... requires a newer version of vim.


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" #############################################################################
" ### Global Settings
" #############################################################################

color elflord
set autoindent
" Open file at last location.
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" #############################################################################
" ### Python Settings
" #############################################################################

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab | 
    \ set autoindent |
    \ set fileformat=unix |
    \ set encoding=utf-8


" #############################################################################
" ### XML Settings
" #############################################################################

if executable('xmllint')
	au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
endif

" #############################################################################
" ### Coverage Settings
" #############################################################################

highlight line_not_covered guifg=red ctermfg=red
highlight line_covered guifg=green ctermfg=green

au BufRead,BufWrite *.cov
    \ syntax match line_not_covered /^[^+].*/ |
    \ syntax match line_covered /^+.*/

