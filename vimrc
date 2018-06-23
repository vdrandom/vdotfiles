" various settings
set nobackup nomodeline backspace=indent,eol,start foldmethod=marker cursorline mouse=
" hidden characters
set list listchars=tab:\|_,nbsp:x,trail:*
" search
set hlsearch incsearch ignorecase smartcase
" scroll before reaching the first / final line
set scrolloff=3 sidescrolloff=15 sidescroll=1
" disable bell
set noerrorbells visualbell t_vb=
" indentation
set tabstop=3 softtabstop=4 shiftwidth=4 smarttab expandtab
" termcap fixes
set t_Co=256 t_ut= termencoding=utf-8 encoding=utf-8
" status line
set wildmenu showcmd ruler laststatus=2
set statusline=[%F]\ %R%H%W%M\ %=[%{&fenc}/%{&ff}]\ %y\ [%4l/%L:%3v]
" enable case indentation
let g:sh_indent_case_labels=1
" version specific settings
if v:version >= 703
    set colorcolumn=80 relativenumber formatoptions+=j
endif

" maps
"leader
map <Space> <NOP>
let mapleader="\<Space>"
"no more F1
noremap <F1> <Esc>
xnoremap <F1> <Esc>
snoremap <F1> <Esc>
inoremap <F1> <Esc>
lnoremap <F1> <Esc>
cnoremap <F1> <Esc>
"some toggles
nnoremap <Leader>l :setlocal list!<CR>
nnoremap <Leader>c :setlocal cursorline!<CR>
nnoremap <Leader>w :setlocal wrap!<CR>
"turn off highlight until next search
nnoremap <Leader>/ :noh<CR>
"copy to / paste from clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
"move macro somewhere I won't accidentally use it
noremap q <NOP>
"quit / save
nnoremap <Leader>q :q<CR>
nnoremap <Leader>s :w<CR>

if v:version >= 800
    set breakindent

    " signify options
    let g:signify_vcs_list = [ 'git' ]
    let g:signify_sign_change = '~'

    " easy-align options
    xmap <Leader>a <Plug>(EasyAlign)
    nmap <Leader>a <Plug>(EasyAlign)

    " only plug vimwiki within vimwiki dir and this file
    if expand('%:p:h') =~ 'vimwiki'
        packadd vimwiki
    endif

    " yaaay themes
    if has('gui_running') || $TERM =~ '^\(tmux\|st\)'
        let &t_8f = "\033[38;2;%lu;%lu;%lum"
        let &t_8b = "\033[48;2;%lu;%lu;%lum"
        set termguicolors
        colorscheme iceberg
    else
        set bg=light
        colorscheme lucius
    endif
endif

if has('gui_running')
    if has('win32')
        set guifont=Fantasque_Sans_Mono:h11
    else
        set guifont=Fantasque\ Sans\ Mono\ 11
    endif
    set guicursor=a:blinkon0,a:block,i:ver1-Cursor/lCursor,r:hor1-Cursor/lCursor
    set guiheadroom=0 guioptions=aei mouse=a noerrorbells visualbell t_vb=
    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>
endif

syntax on
filetype plugin on
