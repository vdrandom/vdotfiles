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
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
" termcap fixes
set t_Co=256 t_ut= termencoding=utf-8 encoding=utf-8
" enable case indentation
let g:sh_indent_case_labels=1
" version specific settings
if has("nvim") || v:version >= 800
    set breakindent
endif
if has("nvim") || v:version >= 703
    set colorcolumn=80 relativenumber
    nnoremap <Leader>r :setlocal relativenumber!<CR>
endif

" maps
map <Space> <leader>
noremap <F1> <Esc>
" some toggles
nnoremap <Leader>n :setlocal number!<CR>
nnoremap <Leader>l :setlocal list!<CR>
nnoremap <Leader>c :setlocal cursorline!<CR>
nnoremap <Leader>/ :nohls<CR>
"make wrapped lines navigation easier
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
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
endif

colorscheme solarized8_light
syntax on
filetype plugin on
