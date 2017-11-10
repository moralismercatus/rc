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
Plugin 'scrooloose/nerdtree'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tmux-plugins/vim-tmux' " .tmux.conf syntax highlighting, etc.
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'Townk/vim-autoclose'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'Valloric/YouCompleteMe' ... requires a newer version of vim.

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" #############################################################################
" ### Global Settings
" #############################################################################

color elflord
set autoindent
set wildmode=longest,list,full
set wildmenu
" Open file at last location.
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" #############################################################################
" ### Custom Commands
" #############################################################################

command ReverseLines :g/^/m0
command SelectInnerWord :execute 'normal "aviw'
command SelectLine :execute 'normal "a0v$'
command CopyInnerWord :execute 'normal "ayiw' | echo "Copied:" @a
command CopyLine :execute 'normal "ayy' | echo "Copied:" @a
command PasteInnerWord :execute 'normal "aviwp' | echo "Pasted:" @a
command PasteOverLine :execute 'normal "a0v$p' | echo "Pasted:" @a
" Help Commands
command HelpReplaceWholeWords :echo "Help: %s/\\<old\\>/new/g" 
command HelpSubstitute :echo "Help: TODO" 
command HelpDeleteAllLinesMatching :echo "Help: g/pattern/d" 

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
" ### C++ Settings
" #############################################################################

au BufNewFile,BufRead *.c,*.h,*.cpp,*.cxx,*.hpp,*.hxx
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab | 
    \ set autoindent |
    \ set fileformat=unix |
    \ set encoding=utf-8 |
    \ set colorcolumn=80 |
    \ highlight ColorColumn ctermbg=darkgrey


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

" #############################################################################
" ### NERDTree Settings
" #############################################################################

map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" #############################################################################
" ### Airline Settings
" #############################################################################

let g:airline#extensions#tabline#enabled = 1 " Display buffers at tabline when only single tab.
let g:airline#extensions#tabline#fnamemod = ':t' " Just display the filename

" #############################################################################
" ### The Silver Searcher
" #############################################################################

if executable('ag')
    " Use ag instead of grep
    set grepprg=ag\ --nogroup\ --nocolor

    command -nargs=+ -complete=file -bar Ag silent! grep!<args>|cwindow|redraw!
    " bind \ to ag
    nnoremap \ :Ag<SPACE>
else
    echo "Warning: ag not found; ag functionality disabled."
endif
