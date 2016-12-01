set backspace=indent,eol,start
set foldmethod=marker
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nobackup
set ruler
set showcmd
set smartcase
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" scroll before reaching the first / final line set scrolloff=3
set sidescrolloff=15
set sidescroll=1
" disable bell
set noerrorbells visualbell t_vb=
" indentation_RIP
"set shiftwidth=3 tabstop=3 noexpandtab
" indentation_OK
set tabstop=3 softtabstop=4 shiftwidth=4 smarttab expandtab

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" 256 colours at almost all times
if $TERM =~ '^[xterm|rxvt-unicode|screen|st]'
    let &t_Co=256
endif
if $LANG =~ '[UTF\-8|utf8]$'
    set termencoding=utf-8
    set encoding=utf-8
endif

" insert shebang in the beginning of the file based on its name extension
autocmd BufNewFile *.zsh 0put =\"#!/usr/bin/env zsh\<nl>\"|$
autocmd BufNewFile *.lua 0put =\"#!/usr/bin/env lua\<nl>\"|$
autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\"|$
autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python3\<nl>\"|$
autocmd BufNewFile *.pl 0put =\"#!/usr/bin/env perl\<nl>\use strict;\<nl>\use warnings;\<nl>\use feature 'say';\<nl>\"|$

" maps
let mapleader = ","
noremap <F1> <Esc>
"fold/unfold via spacebar
nnoremap <Space> za
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

" still have to deal with old vim versions :<
if v:version >= 700
    if v:version >= 703
        set colorcolumn=80
        set relativenumber
        nnoremap <Leader>r :setlocal relativenumber!<CR>
    endif
    if v:version >= 800
        set breakindent
    endif

    set helplang=en
    set list
    set number
    set listchars=tab:\|_,nbsp:x,trail:*
    nnoremap <Leader>n :setlocal number!<CR>
    nnoremap <Leader>l :setlocal list!<CR>

    " enable case indentation
    let g:sh_indent_case_labels=1

    " plugins
    if filereadable(expand("$HOME/.vim/plugged/vim-plug/plug.vim"))
        set noshowmode
        source ~/.vim/plugged/vim-plug/plug.vim
        silent!call plug#begin('~/.vim/plugged')
        Plug 'junegunn/vim-plug'               "plugin manager

        " general plugins
        Plug 'Lokaltog/vim-easymotion'         "easy motion
        Plug 'directionalWindowResizer'        "resize windows with simple hotkeys
        Plug 'jeetsukumaran/vim-buffergator'   "buffer management
        Plug 'junegunn/vim-easy-align'         "aligning
        Plug 'mhinz/vim-signify'               "version control system gutter info
        Plug 'nvie/vim-togglemouse'            "hotkey to toggle mouse
        Plug 'vim-airline/vim-airline'         "airline
        Plug 'vim-airline/vim-airline-themes'  "themes for airline
        " Plug 'itchyny/lightline.vim'           "simpler airline replacement
        Plug 'vimwiki/vimwiki'                 "another attempt at doing notebook via vim
        Plug 'neomake/neomake'                 "linter

        " colorschemes
        Plug 'lifepillar/vim-solarized8'
        Plug 'KeitaNakamura/neodark.vim'
        Plug 'morhetz/gruvbox'

        " syntax highlight plugins
        Plug 'neilhwatson/vim_cf3'
        call plug#end()

        " easymotion options
        let g:EasyMotion_do_mapping=0
        let g:EasyMotion_smartcase=1
        nmap f <Plug>(easymotion-s)
        map <Leader>j <Plug>(easymotion-j)
        map <Leader>k <Plug>(easymotion-k)

        " airline options
        let g:airline_symbols={}
        let g:airline_symbols.whitespace='!'
        let g:airline_powerline_fonts=1
        let g:airline_extensions=['hunks']
        let g:airline_section_z='%3p%% %{g:airline_symbols.linenr}%4l:%3v'

        " buffergator options
        map <Leader><Tab> :BuffergatorToggle<CR>

        " signify options
        let g:signify_vcs_list=[ 'svn', 'git', 'fossil' ]
        let g:signify_sign_change='~'

        " vim-togglemouse options
        nmap <Leader>m <F12>

        " easy-align options
        xmap <Leader>a <Plug>(EasyAlign)
        nmap <Leader>a <Plug>(EasyAlign)

        " neomake
        nmap <Leader>p :Neomake<CR>
        let g:neomake_error_sign={
                    \ 'text': 'e>',
                    \ 'texthl': 'ErrorMsg',
                    \ }
        let g:neomake_warning_sign={
                    \ 'text': 'w>',
                    \ 'texthl': 'WarningMsg',
                    \ }
        let g:neomake_info_sign={
                    \ 'text': 'i>',
                    \ 'texthl': 'InfoMsg',
                    \ }

        let g:solarized_visibility='low'
    endif

    " gvim and colorschemes related stuff
    if has("gui_running")
        set guioptions=aegimLl
        set mouse=a
        set guifont=Terminus\ 11
        set novb
        set guicursor=a:hor1-Cursor/lCursor     "underline cursor by default
        set guicursor+=i:ver1-Cursor/lCursor    "vertical cursor for insert mode
        set guicursor+=r:block                  "block for replace
        set guicursor+=a:blinkon0               "and none of them should blink
        colorscheme solarized8_light
        map <S-Insert> <MiddleMouse>
        map! <S-Insert> <MiddleMouse>
    elseif (has("nvim") || v:version >= 704) && $TERM != 'screen'
        " fix tmux and st
        set t_8f=[38;2;%lu;%lu;%lum
        set t_8b=[48;2;%lu;%lu;%lum
        set termguicolors
        colorscheme neodark
        set mouse=
    else
        colorscheme solarized8_light
        set mouse=
    endif
else
    colorscheme default
endif

syntax on

filetype plugin on
