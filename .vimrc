" Vundle
set nocompatible
filetype off

set rtp +=$HOME/.vim/bundle/vundle
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'nixprime/cpsm'
Plugin 'vim-scripts/The-NERD-tree'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/tComment'
Plugin 'haya14busa/incsearch.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-sleuth'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'lyuts/vim-rtags'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'lervag/vimtex'
call vundle#end()

filetype plugin indent on

" Needed for YCM, and generally a pretty good idea
set encoding=utf-8

if has('python3')
  let g:gundo_prefer_python3 = 1
endif

" Graphical undo tree bindings
nnoremap <F5> :GundoToggle<CR>

" NERDTree bindings
map <F8> :NERDTreeToggle<CR>
map <S-F8> :NERDTreeFind<CR>

let mapleader = ","
let g:mapleader = ","

" Enable line numbers
set nu

" highlight search results
set hlsearch

" faster performance
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

syntax enable

" We have sleuth, but set something as default
set expandtab
set nosmartindent
set shiftwidth=4
set tabstop=4 " number of visual spaces per tab

" Move lines up and down (This does not work in most terminals because of Alt)
" TODO: find a better shortcut :(
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" Start scrolling slightly before the cursor reaches an edge
set scrolloff=3
set sidescrolloff=5

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>yw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
setlocal spelllang=nl

" Change default PageUp/Down mappings to stop doing weird things to cursor
" placement
map <PageDown> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-D>:set scroll=0<CR>
map <PageUp> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-U>:set scroll=0<CR>

" show incomplete commands in bottom right corner
set showcmd

" get rid of the delay when pressing O
set timeout timeoutlen=1000 ttimeoutlen=100

" Enable input of special characters by combining two characters
" set digraph

" Enable mouse
" set mouse=a

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup
    let g:grep_cmd_opts = '--line-numbers --noheading'
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l -g ""'
endif

let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Start searching immediately
set incsearch

" enable airline
set laststatus=2
set ttimeoutlen=50

" Swap files are only kept for modified buffers
" Autodeleted when changes are saved
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

" Show list instead of just completing
set wildmenu
set wildmode=longest:full,full

" Ignore case, except when using upper-case letters in search pattern
set ignorecase
set smartcase

" Don't make x overwrite the default register
noremap x "_x

" Make ctrl-v in insert mode automatically enable and disable paste mode
inoremap <C-V> <C-O>:call PasteNoIndent()<CR>

function! PasteNoIndent()
    set paste
    execute "normal" '"+p'
    set nopaste
endfunction

" Visual shifting does not exit Visual mode
vnoremap < <gv
vnoremap > >gv

" Git blame
noremap <leader>gb :Gblame<CR>

" Molokai needs the g:rehash256 = 1 for better colour support
colorscheme molokai
let g:rehash256 = 1
set background=dark
highlight Normal ctermbg=NONE

" Highlight current horizontal line
set cursorline

let g:airline_powerline_fonts = 1

" Find ctags in current directory, then recursively upwards
set tags=./tags;
" ctags previous/next match
nmap <leader>[ :tprevious<CR>
nmap <leader>] :tnext<CR>

" allow local .vimrc file
set exrc
set secure

" Use cppman when using K in cpp files
autocmd FileType cpp set keywordprg=cppman

" Use an undofile and save it somewhere reasonable (outside of working
" directory)
set undofile
set undodir=~/.vim/tmp/undo//

" I haz yy already, so tyvm
nnoremap Y y$

" Remove comment characters when joining lines, if it makes sense
set formatoptions+=j

" Toggle rainbow parentheses
nmap <F6> :RainbowParenthesesToggle<CR>

" switch between html tags
runtime macros/matchit.vim

" Synctex support
" let g:vimtex_complete_close_braces = 1
" let g:vimtex_latexmk_options = '-verbose -pdf -file-line-error -synctex=1 -interaction=nonstopmode --shell-escape'
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'

" vimtex/YCM support
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
