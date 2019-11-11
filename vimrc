set nobackup nomodeline backspace=indent,eol,start foldmethod=marker cursorline
set list listchars=tab:\|_,nbsp:x,trail:*
set hlsearch incsearch ignorecase smartcase
set scrolloff=3 sidescrolloff=15 sidescroll=1
set tabstop=3 softtabstop=4 shiftwidth=4 smarttab expandtab autoindent
set wildmenu showcmd ruler laststatus=2
set statusline=[%F]\ %R%H%W%M\ %=[%{&fenc}/%{&ff}]\ %y\ [%4l/%L:%3v]
set belloff=all colorcolumn=80 formatoptions+=j relativenumber breakindent
set keymap=russian-jcukenwintype iminsert=0 imsearch=0
set title titlestring=[%{hostname()}]\ %t\ -\ vim

let g:netrw_liststyle = 1
let g:sh_indent_case_labels = 1

" mappings
map <Space> <NOP>
let mapleader="\<Space>"
noremap <F1> <Esc>
noremap! <F1> <Esc>
nnoremap <Leader>l :setlocal list!<CR>
nnoremap <Leader>c :setlocal cursorline!<CR>
nnoremap <Leader>w :setlocal wrap!<CR>
noremap <Leader>/ :noh<CR>
noremap <Leader>y "+y
noremap <Leader>d "+d
noremap <Leader>p "+p
noremap <Leader>P "+P
noremap q <NOP>
noremap! <C-@> <C-^>
noremap! <C-Space> <C-^>

" plugins
let plugrc = expand('$HOME/.vimplugrc')
let plugdir = expand('$HOME/.vim/plugged')
if filereadable(plugrc) && v:version >= 703
    execute 'source' fnameescape(plugrc)
endif

if $TERM =~ '^screen'
    set t_ts=k t_fs=\
endif

if has('gui_running')
    set guifont=Fantasque\ Sans\ Mono\ 11
    set guicursor=a:blinkon0,a:block,i:ver1-Cursor/lCursor,r:hor1-Cursor/lCursor
    set guiheadroom=0 guioptions=aeim mouse=a

    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>
else
    set mouse=
endif

syntax on
filetype plugin on
