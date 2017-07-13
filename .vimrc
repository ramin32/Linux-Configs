set nocompatible
set nu
set mouse=a
syntax on
filetype on
filetype plugin indent on
set et
set sts=4
set sw=4
set ts=4
au CursorHold * update
au CursorHold * checktime
au CursorHoldI * update
set ut=500
set title
set ai
noremap <C-t> :CommandT<CR>
let g:netrw_banner = 0
colorscheme darkblue
set guifont=Terminus\ Bold\ 14 
set hls
set backspace=2
set autoread
setlocal spell spelllang=en_us
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,*.jpeg,*.o,*.obj,.git,ENV/**,node_modules/**,uploads/**,.*,uploads,node_modules,uploads,ENV
execute pathogen#infect()

