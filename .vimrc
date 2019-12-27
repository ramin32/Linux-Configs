set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'wincent/command-t'
Plugin 'dense-analysis/ale'
Plugin 'valloric/matchtagalways'
Plugin 'scrooloose/nerdtree'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'ervandew/supertab'
Plugin 'pangloss/vim-javascript'

call vundle#end()
filetype plugin indent on

set nu
set mouse=a
syntax on
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


