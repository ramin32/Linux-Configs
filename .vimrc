set nocompatible
set nu
set mouse=a
call pathogen#infect()
syntax on
filetype on
filetype plugin indent on
set et
set sts=4
set sw=4
set ts=4
set makeprg=ant\ -emacs
au CursorHold * update
au CursorHoldI * update
au CursorHold * checktime
set ut=500
autocmd VimEnter * wincmd p
set title
set ai
noremap <C-t> :CommandT<CR>
colorscheme darkblue
set guifont=Terminus\ Bold\ 14 
source ~/.vim/plugin/matchit.vim
set hls
imap <D-V> ^O"+p
set wildignore+=*.o,*.obj,.git,ENV/**
let g:CommandTWildIgnore="*.o,*.obj,.git,*.pyc,**/ENV/**,node_modules,node_modules/**"
let NERDTreeIgnore = ['\.pyc$', 'node_modules']
set backspace=2
set autoread
setlocal spell spelllang=en_us
let g:jsx_ext_required = 0
let g:CommandTTraverseSCM="pwd"

