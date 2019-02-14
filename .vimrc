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
    " Plugin manager.
    " Must be the first 'Plugin'.
Plugin 'sheerun/vim-polyglot'
" Plugin 'vim-scripts/indentpython.vim'
    " Python convenciences.
Plugin 'tomtom/tcomment_vim'
    " Commands for commenting or uncommenting code lines.
Plugin 'othree/xml.vim'
    " XML highlighting, formatting, etc.
Plugin 'christoomey/vim-tmux-navigator'
    " Seamless integration of tmux of vim navigation.
Plugin 'tmux-plugins/vim-tmux'
    " .tmux.conf syntax highlighting, etc.
Plugin 'MattesGroeger/vim-bookmarks'
    " Bookmark conveniences.
Plugin 'tpope/vim-fugitive'
    " git interaction within vim.
Plugin 'tpope/vim-vinegar'
    " netrw extensions.
" Plugin 'powerline/fonts'
Plugin 'vim-airline/vim-airline'
    " Statusline and tabline improvements.
Plugin 'vim-airline/vim-airline-themes'
    " Themes to choose from for vim-airline.
Plugin 'Townk/vim-autoclose'
    " Automatically closes quotes, parens, braces, etc.
Plugin 'ctrlpvim/ctrlp.vim'
    " Fuzzer file finder.
Plugin 'simnalamburt/vim-mundo.git'
    " Utility for viewing file changes.
Plugin 'majutsushi/tagbar'
    " Symbol viewer for editor.
Plugin 'fidian/hexmode'
    " Hex viewer for binary mode.
Plugin 'ludovicchabant/vim-gutentags'
    " Automatic ctag generation.
Plugin 'morhetz/gruvbox'
    " Color scheme.
Plugin 'nathanaelkane/vim-indent-guides'
    " Customizable indent guides.
Plugin 'neomake/neomake'
    " Async build commands.
Plugin 'jeetsukumaran/vim-buffergator'
    " Buffer utilities.
Plugin 'junegunn/vim-easy-align'
    " Rules and commands for aligning text.
Plugin 'mtth/scratch.vim'
    " Simple scratch pad.
Plugin 'will133/vim-dirdiff'
    " vim-diff for directories of files.
Plugin 'zefei/vim-wintabs'
    " Manages tabline.
    " Delineates buffers by tab.
    " Plugin must succeed vim-airline.
Plugin 'EinfachToll/DidYouMean'
    " Prevents accidental opening of a new file on tab-complete conflict.
" Plugin 'zefei/vim-wintabs-powerline'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'rdnetto/YCM-Generator'


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
" Switch buffers without saving.
set hidden
" Automatically use case-sensitive search if a capital is used.
" Note that \C must be included somewhere in the search expression now when
" case senitivity is needed. 
set ignorecase
set smartcase
" Turn off line-wrapping by default. Re-enable with :set wrap
set nowrap
" Turn on relative line numbers.
set relativenumber
" Force sudo write when forgot to open in sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

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
" ### Javascript Settings
" #############################################################################

au BufNewFile,BufRead *.js
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
" ### Airline Settings
" #############################################################################

let g:airline#extensions#tabline#enabled = 1 " Display buffers at tabline when only single tab.
let g:airline#extensions#tabline#fnamemod = ':t' " Just display the filename
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='angr'

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
" Creates a local bookmark file for pwd, instead of global bookmarking.
let g:bookmark_save_per_working_dir = 1
" Since using local pwd bookmarks, load bookmark each time buffer changes.
let g:bookmark_manage_per_buffer = 1

" #############################################################################
" ### Neomake Settings
" #############################################################################

" Open quickfix window with output messages. 1 focuses the quickfix.
let g:neomake_open_list = 1
let g:neomake_verbose = 1
let g:airline#extensions#neomake#enabled = 1
command Make Neomake!

" #############################################################################
" ### diff Settings
" #############################################################################

" Automatically call :diffupdate upon writing file in diff mode.
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" #############################################################################
" ### YouCompleteMe Settings
" #############################################################################
let g:ycm_collect_identifiers_from_tags_files = 1
nnoremap <C-]> :YcmComplete GoTo<ENTER>

" #############################################################################
" ### Tags Settings
" #############################################################################
" Cause go-to tag list all available if more than one found.
nnoremap <C-]><C-]> g<C-]>
 
" #############################################################################
" ### Clipboard Settings
" #############################################################################
" Implicility synchronizes all clipboard to system clipboard.
" set clipboard+=unnamedplus

" Delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Replace currently selected text without default register without yanking it
vnoremap <leader>p "_dP

