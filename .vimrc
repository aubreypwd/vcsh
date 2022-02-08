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
