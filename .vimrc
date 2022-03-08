syntax on
:set nowrap

"@see https://askubuntu.com/questions/74485/how-to-display-hidden-characters-in-vim/74503
:set list

:set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»

imap ii <Esc> "@see https://news.ycombinator.com/item?id=13100718

set termguicolors "Stick to terminal colors

:set mouse=a
:set clipboard=unnamed

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
	Plug 'tpope/vim-surround'
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'mutewinter/nginx.vim'
	Plug 'rhysd/committia.vim'
call plug#end()

" UI
set termguicolors
"colorscheme monokai_pro
colorscheme vim-monokai-tasty
set background=dark
hi Normal ctermbg=16 guibg=#121212
hi LineNr ctermbg=16 guibg=#121212
