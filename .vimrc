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
Plugin 'simnalamburt/vim-mundo.git'
Plugin 'majutsushi/tagbar'
Plugin 'fidian/hexmode'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'morhetz/gruvbox'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'neomake/neomake'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'junegunn/vim-easy-align'
Plugin 'mtth/scratch.vim'
"Plugin 'Valloric/YouCompleteMe' ... requires a newer version of vim.

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" #############################################################################
" ### Global Settings
" #############################################################################

" Force vim to use 256 colors, if available in term. Must precede colorscheme.
" May require additional settings inside of e.g., tmux. e.g., `tmux -2`.
set t_Co=256
colorscheme gruvbox
set background=dark
set autoindent
set wildmode=longest,list,full
set wildmenu
" Open file at last location.
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
" Cause go-to tag list all available if more than one found.
nnoremap <C-]> g<C-]>
" Switch buffers without saving.
set hidden
" Automatically use case-sensitive search if a capital is used.
" Note that \C must be included somewhere in the search expression now when
" case senitivity is needed. 
set ignorecase
set smartcase
" Turn off line-wrapping by default. Re-enable with :set wrap
set nowrap

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
" ### The Silver Searcher (ag)
" #############################################################################

if executable('ag')
    " Use ag instead of grep
    set grepprg=ag\ --nogroup\ --nocolor

    command -nargs=+ -complete=file -bar Ag silent! grep!<args>|cwindow|redraw!
    " Bind \ to ag
    nnoremap \ :Ag<SPACE>
    " Bind \\ to use ag to search for the word under cursor.
    nnoremap \\ :Ag <C-R><C-W><ENTER>
    " Display all TODOs by textual search.
    command TodoShow :Ag TODO
else
    echo "Warning: ag not found; ag functionality disabled."
endif

" #############################################################################
" ### CtrlP Settings
" #############################################################################

let g:ctrlp_cmd = 'CtrlPMixed'

" #############################################################################
" ### Undo tree Settings
" #############################################################################

if has("persistent_undo")
    call system('mkdir ~/.vim.undodir')
    set undodir=~/.vim.undodir/
    set undofile
endif

" #############################################################################
" ### Tagbar Settings
" #############################################################################

let g:tagbar_left = 1
" Autocmds will mess up vimdiff, so only set when not diffing.
if !&diff 
    autocmd VimEnter * nested :call tagbar#autoopen(1)
    autocmd FileType * nested :call tagbar#autoopen(0)
    " Open TagBar only when a valid file or TagBar itself.
    " Otherwise, close it.
    " autocmd BufEnter * nested :if tagbar#isvalid(b)... then... :TagbarOpen...
    " else :TagbarClose
endif


" #############################################################################
" ### Indent Guide Settings
" #############################################################################

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1

" #############################################################################
" ### Bookmark Settings
" #############################################################################

" I like CtrlP's UI, but it doesn't seem suited to Bookmarks.
let g:bookmark_disable_ctrlp = 1
let g:bookmark_auto_close = 1

" #############################################################################
" ### Neomake Settings
" #############################################################################

" Open quickfix window with output messages. 1 focuses the quickfix.
let g:neomake_open_list = 1
let g:neomake_verbose = 1
