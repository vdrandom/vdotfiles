" various settings
set nobackup nomodeline backspace=indent,eol,start foldmethod=marker cursorline mouse=
" hidden characters
set list listchars=tab:\|_,nbsp:x,trail:*
" search
set hlsearch incsearch ignorecase smartcase
" scroll before reaching the first / final line
set scrolloff=3 sidescrolloff=15 sidescroll=1
" disable bell
set noerrorbells visualbell
" indentation
set tabstop=3 softtabstop=4 shiftwidth=4 smarttab expandtab autoindent
" status line
set wildmenu showcmd ruler laststatus=2
set statusline=[%F]\ %R%H%W%M\ %=[%{&fenc}/%{&ff}]\ %y\ [%4l/%L:%3v]
" update window title
if $TERM =~ '^screen'
    set t_ts=k
    set t_fs=\
endif
set title titlestring=[%{hostname()}]\ %t\ -\ vim
" enable case indentation
let g:sh_indent_case_labels=1
" version specific settings
if v:version >= 703
    set colorcolumn=80 relativenumber formatoptions+=j
endif
" fix termcap and ttymouse, but not for neovim
if !has('nvim')
    set ttymouse=sgr t_vb= t_Co=256 t_8f=[38;2;%lu;%lu;%lum t_8b=[48;2;%lu;%lu;%lum
endif

" maps
"leader
map <Space> <NOP>
let mapleader="\<Space>"
"no more F1
noremap <F1> <Esc>
lnoremap <F1> <Esc>
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

    " easy-align options
    xmap <Leader>a <Plug>(EasyAlign)
    nmap <Leader>a <Plug>(EasyAlign)

    " enable packs based on filetype
    let g:ale_python_flake8_executable = 'python2'
    autocmd FileType python packadd ale | packadd jedi-vim
    autocmd FileType sh packadd ale

    if $TERM != 'linux'
        color solarized8
    endif
endif

syntax on
filetype plugin on
