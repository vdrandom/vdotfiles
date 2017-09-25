" various settings
set nobackup number nomodeline cursorline backspace=indent,eol,start
set foldmethod=marker ttymouse=xterm2 mouse=
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
if v:version >= 800
    set breakindent keymap=russian-jcukenwintype iminsert=0 imsearch=0
    inoremap <C-@> <C-^>
    cnoremap <C-@> <C-^>
    inoremap <C-Space> <C-^>
    cnoremap <C-Space> <C-^>
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
nnoremap <Leader>n :setlocal number!<CR>
nnoremap <Leader>r :setlocal relativenumber!<CR>
nnoremap <Leader>l :setlocal list!<CR>
nnoremap <Leader>c :setlocal cursorline!<CR>
nnoremap <Leader>v :setlocal wrap!<CR>
"turn off highlight until next search
nnoremap <Leader>/ :noh<CR>
"home / end
noremap H ^
noremap L $
"copy to / paste from clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
"move macro somewhere I won't accidentally use it
noremap Q q
noremap q <NOP>
"quit / save
nnoremap qq :q<CR>
nnoremap qf :q!<CR>
nnoremap qa :qa<CR>
nnoremap qs :wq<CR>
nnoremap <Leader>s :w<CR>

" mouse toggle
fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "mouse enabled (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "mouse disabled"
    endif
endfunction
noremap <Leader>m :call <SID>ToggleMouse()<CR>

" plugins
let plugins = expand("$HOME/.vimplugins")
if filereadable(plugins) && v:version >= 703
    execute 'source ' . fnameescape(plugins)
endif

let g:solarized_term_italics = 1
colorscheme solarized8_light
syntax on
filetype plugin on
