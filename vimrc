set backspace=indent,eol,start
set foldmethod=marker
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nobackup
set nomodeline
set ruler
set showcmd
set smartcase
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set wildmenu
" scroll before reaching the first / final line
set scrolloff=3
set sidescrolloff=15
set sidescroll=1
" disable bell
set noerrorbells visualbell t_vb=
" indentation_RIP
"set shiftwidth=3 tabstop=3 noexpandtab
" indentation_OK
set tabstop=3 softtabstop=4 shiftwidth=4 smarttab expandtab

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" termcap fixes
set t_Co=256
set t_ut=
set termencoding=utf-8
set encoding=utf-8
set fillchars+=vert:│

" maps
map <Space> <leader>
noremap <F1> <Esc>
"enable cursorline on demand
nnoremap <Leader>c :set cursorline!<CR>
"clear search highlight
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
nmap qq :q<CR>
nmap qf :q!<CR>
nmap qa :qa<CR>
nmap qw :wq<CR>
nmap <Leader>w :w<CR>

" still have to deal with old vim versions :<
if v:version >= 703
    set colorcolumn=80
    set relativenumber
    nnoremap <Leader>r :setlocal relativenumber!<CR>
endif
if v:version >= 800
    set breakindent
endif

set mouse=

set helplang=en
set list
set number
set listchars=tab:\|_,nbsp:x,trail:*
nnoremap <Leader>n :setlocal number!<CR>
nnoremap <Leader>l :setlocal list!<CR>

" enable case indentation
let g:sh_indent_case_labels=1

" plugins
if filereadable(expand("$HOME/vdotfiles/plugins.vim"))
    source ~/vdotfiles/plugins.vim
endif

colorscheme solarized8_light

syntax on

filetype plugin on
