" various settings
set number helplang=en foldmethod=marker ttymouse=xterm2 mouse=
set history=50 nobackup nomodeline backspace=indent,eol,start
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
" status line
set wildmenu showcmd ruler laststatus=2
set statusline=%F\ %m%r%h%w%=%y\ [%{&ff}]\ [%4l/%L:%3v]\ [%3p%%]
" termcap fixes
set t_Co=256 t_ut= termencoding=utf-8 encoding=utf-8
" enable case indentation
let g:sh_indent_case_labels=1
" version specific settings
if has("nvim") || v:version >= 800
    set breakindent
    set keymap=russian-jcukenwintype iminsert=0 imsearch=0
    inoremap <C-@> <C-^>
    cnoremap <C-@> <C-^>
    inoremap <C-Space> <C-^>
    cnoremap <C-Space> <C-^>
endif
if has("nvim") || v:version >= 703
    set colorcolumn=80 relativenumber
    nnoremap <Leader>r :setlocal relativenumber!<CR>
endif

" maps
" leader
map <Space> <NOP>
let mapleader="\<Space>"
" no more F1
noremap <F1> <Esc>
" some toggles
nnoremap <Leader>n :setlocal number!<CR>
nnoremap <Leader>l :setlocal list!<CR>
nnoremap <Leader>c :setlocal cursorline!<CR>
nnoremap <Leader>/ :nohls<CR>
"home / end
nnoremap H ^
nnoremap L $
"copy to / paste from clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
"move macro somewhere I won't accidentally use it
nnoremap Q q
nnoremap q <Nop>
"quit / save
nnoremap qq :q<CR>
nnoremap qf :q!<CR>
nnoremap qa :qa<CR>
nnoremap qw :wq<CR>
nnoremap <Leader>w :w<CR>

" plugins
let plugins = expand("$HOME/.vimplugins")
if filereadable(plugins)
    execute 'source ' . fnameescape(plugins)
else
    colorscheme solarized8_light
endif

syntax on
filetype plugin on
