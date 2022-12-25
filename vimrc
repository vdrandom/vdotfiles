vim9script
set nobackup nomodeline backspace=indent,eol,start foldmethod=marker cursorline
set list listchars=tab:-->,nbsp:x,trail:*
set hlsearch incsearch ignorecase smartcase
set scrolloff=3 sidescrolloff=15 sidescroll=1
set tabstop=3 softtabstop=4 shiftwidth=4 smarttab expandtab autoindent
set wildmenu showcmd ruler laststatus=2 mouse= t_ut= guicursor= t_Co=256
set belloff=all colorcolumn=80 formatoptions+=j relativenumber breakindent
set keymap=russian-jcukenwintype iminsert=0 imsearch=0
&statusline = "[%F] %R%H%W%M %=[%{&fenc}/%{&ff}] %y [%4l/%L:%3v]"
g:sh_indent_case_labels = 1

# mappings
map <Space> <NOP>
var mapleader = '\<Space>'
noremap  <F1> <Esc>
noremap  <Leader>/ :noh<CR>
noremap  <Leader>y "+y
noremap  <Leader>d "+d
noremap  <Leader>p "+p
noremap  <Leader>P "+P
noremap  q <NOP>
noremap! <F1> <Esc>
noremap! <C-@> <C-^>
noremap! <C-Space> <C-^>
nnoremap <Leader>l :setlocal list!<CR>
nnoremap <Leader>c :setlocal cursorline!<CR>
nnoremap <Leader>w :setlocal wrap!<CR>

g:plugrc  = expand('$HOME/.vimplugrc')
g:plugdir = expand('$HOME/.vim/plugged')
g:plug    = g:plugdir .. '/vim-plug/plug.vim'
if filereadable(g:plugrc) && filereadable(g:plug) && v:version >= 703
    execute 'source' fnameescape(g:plugrc)
endif

syntax on
filetype plugin on
