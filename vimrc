set nocompatible
set background=dark
set backspace=indent,eol,start
set cursorline
set foldmethod=marker
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nobackup
set noexpandtab
set ruler
set showcmd
set smartcase
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" scroll before reaching the first / final line set scrolloff=3
set sidescrolloff=15
set sidescroll=1
" disable bell
set noerrorbells visualbell t_vb=

" 256 colours at almost all times
if $TERM =~ '^[xterm|rxvt-unicode|screen]'
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

autocmd FileType python setlocal softtabstop=4 shiftwidth=4 colorcolumn=80 smarttab expandtab autoindent

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
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
"home / end
nnoremap H ^
nnoremap L $

" still have to deal with old vim versions :<
if v:version >= 700
	set helplang=en
	set modeline

	set number
	set list
	set listchars=tab:\|_,nbsp:x
	nnoremap <Leader>n :setlocal number!<CR>
	nnoremap <Leader>l :setlocal list!<CR>

	" enable case indentation
	let g:sh_indent_case_labels=1

	" plugins
	if filereadable(expand("$HOME/.vim/plugged/vim-plug/plug.vim"))
		set noshowmode
		source ~/.vim/plugged/vim-plug/plug.vim
		call plug#begin('~/.vim/plugged')
		Plug 'junegunn/vim-plug'               "plugin manager

		" general plugins
		Plug 'Lokaltog/vim-easymotion'         "easy motion
		Plug 'Shougo/unite.vim'                "fuzzy file open
		Plug 'vim-airline/vim-airline'         "stylish info display
		Plug 'vim-airline/vim-airline-themes'  "themes for airline
		Plug 'bling/vim-bufferline'            "stylish buffer display
		Plug 'jeetsukumaran/vim-buffergator'   "buffer management
		Plug 'mhinz/vim-signify'               "version control system gutter info
		Plug 'scrooloose/nerdtree'             "file manager
		Plug 'tpope/vim-fugitive'              "git awesomeness
		Plug 'tpope/vim-surround'              "quotes replacement made easy
		Plug 'directionalWindowResizer'        "resize windows with simple hotkeys

		" colorschemes
		Plug 'jonathanfilip/vim-lucius'
		Plug 'morhetz/gruvbox'
		Plug 'romainl/Apprentice'
		Plug 'vdrandom/forked-solarized.vim'

		" syntax highlight plugins
		Plug 'puppetlabs/puppet-syntax-vim'
		Plug 'nagios-syntax'
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
		let g:airline_theme='base16'

		" buffergator options
		map <Leader><Tab> :BuffergatorToggle<CR>

		" bufferline options
		let g:bufferline_show_bufnr=0

		" nerdtree options
		let NERDTreeDirArrows=0
		map <Leader>, :NERDTreeToggle<CR>

		" signify options
		let g:signify_vcs_list=[ 'svn', 'git' ]
		let g:signify_sign_change='~'
	endif

	" gvim and colorschemes related stuff
	if has("gui_running")
		let NERDTreeDirArrows=1
		set guioptions=aegimLl
		set mouse=a
		set guifont=Terminus\ 11
		set novb
		set guicursor=a:hor1-Cursor/lCursor     "underline cursor by default
		set guicursor+=i:ver1-Cursor/lCursor    "vertical cursor for insert mode
		set guicursor+=r:block                  "block for replace
		set guicursor+=a:blinkon0               "and none of them should blink
		map <S-Insert> <MiddleMouse>
		map! <S-Insert> <MiddleMouse>
	else
		set mouse=
	endif

	let g:solarized_italic=0
	let g:solarized_underline=0
	let g:solarized_visibility='low'
	colorscheme solarized
else
	colorscheme elflord
endif

syntax on

filetype plugin on
