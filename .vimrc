set nu
set mouse=a
syntax on
filetype plugin indent on
set et
set sts=4
set sw=4
set ts=8
set makeprg=ant\ -emacs
au CursorHold * update
au CursorHoldI * update
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
set wildignore+=*.o,*.obj,.git,*.png,*.gif,*.jpg,*.jpeg
let NERDTreeIgnore = ['\.pyc$']
set wildignore+=*.o,*.obj,.git,ENV
set backspace=2
