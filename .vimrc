set nocompatible
set nu
set mouse=a
syntax on
filetype on
filetype plugin indent on
set et
set sts=2
set sw=2
set ts=2
au CursorHold * update
au CursorHold * checktime
au CursorHoldI * update
set ut=500
set title
set ai
noremap <C-t> :CommandT<CR>
noremap <C-n> :NERDTree<CR>
noremap <C-e> :ALEDetail<CR>
let g:netrw_banner = 0
colorscheme darkblue
set guifont=Terminus\ Bold\ 14 
set hls
set backspace=2
set autoread
setlocal spell spelllang=en_us
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,*.jpeg,*.o,*.obj,.git,ENV/**,node_modules/**,uploads/**,.*,uploads,node_modules,uploads,ENV
execute pathogen#infect()
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
