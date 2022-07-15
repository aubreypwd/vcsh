syntax on
set nowrap

"@see https://askubuntu.com/questions/74485/how-to-display-hidden-characters-in-vim/74503
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»

imap ii <Esc> "@see https://news.ycombinator.com/item?id=13100718

set termguicolors "Stick to terminal colors

"@see https://marioyepes.com/vim-setup-for-modern-web-development/
set mouse=a
set clipboard=unnamed
set nocompatible
set number                " Show numbers on the left
set hlsearch              " Highlight search results
set ignorecase            " Search ingnoring case
set smartcase             " Do not ignore case if the search patter has uppercase
set noerrorbells          " I hate bells
    set belloff=esc
set tabstop=2             " Tab size of x spaces
set expandtab             " Use apropiate number of spaces
set noswapfile            " Do not leve any backup files
set mouse=a               " Enable mouse on all modes
set clipboard=unnamed,unnamedplus     " Use the OS clipboard
set showmatch
set termguicolors
set splitright splitbelow
set list lcs=tab:\¦\      "(here is a space)
let &t_SI = "\e[6 q"      " Make cursor a line in insert
let &t_EI = "\e[2 q"      " Make cursor a line in insert

" Keep VisualMode after indent with > or <
vmap < <gv
vmap > >gv
"
" Move Visual blocks with J an K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Autocomand to remember las editing position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

autocmd BufRead,BufNewFile *.md,*.txt setlocal wrap " DO wrap on markdown files
autocmd BufRead,BufNewFile * start "Start in edit mode

"For committing
set cc=51,71
highlight ColorColumn ctermbg=0 guibg=black
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%51v.*/

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC
\| endif

"Plugins
call plug#begin('~/.vim/plugged')
    "Plug 'phanviet/vim-monokai-pro'
    Plug 'patstockwell/vim-monokai-tasty'
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    "Plug 'nathanaelkane/vim-indent-guides'
    Plug 'mutewinter/nginx.vim'
    Plug 'rhysd/committia.vim'
    "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Install fuzzy finder binary
    "Plug 'junegunn/fzf.vim'
    Plug 'editorconfig/editorconfig-vim'  " Tab/Space trough projects
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" UI
set termguicolors
"colorscheme monokai_pro
colorscheme vim-monokai-tasty
set background=dark
hi Normal ctermbg=16 guibg=NONE
hi LineNr ctermbg=16 guibg=NONE

set backspace=indent,eol,start

let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-phpls',
    \ 'coc-python',
    \ 'coc-diagnostic'
    \]

set list
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
