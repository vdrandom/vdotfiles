set nocompatible
set background=dark
set backspace=indent,eol,start
set clipboard=exclude:.*
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
" scroll before reaching the first / final line
set scrolloff=3
set sidescrolloff=15
set sidescroll=1
" disable bell
set noerrorbells visualbell t_vb=

" 256 colours at almost all times as well as cursor shape changes
" Relies on tmux, fails spectacularly with screen!
if $TERM =~ '^[xterm|rxvt-unicode|screen]'
	let &t_Co=256
	if $TERM =~ '^screen'
		let &t_SI = "\<Esc>Ptmux;\<Esc>\e[6 q\<Esc>\\"
		let &t_EI = "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
	else
		let &t_SI = "\<Esc>[6 q"
		let &t_EI = "\<Esc>[4 q"
	endif
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
	if filereadable(expand("$HOME/.vim/bundle/Vundle.vim/autoload/vundle.vim"))
		filetype off
		set noshowmode
		set rtp+=~/.vim/bundle/Vundle.vim/
		silent! call vundle#begin()
		Plugin 'gmarik/Vundle.vim'               "plugin manager

		" general plugins
		Plugin 'Lokaltog/vim-easymotion'         "easy motion
		Plugin 'Shougo/unite.vim'                "fuzzy file open
		Plugin 'bling/vim-airline'               "stylish info display
		Plugin 'bling/vim-bufferline'            "stylish buffer display
		Plugin 'jeetsukumaran/vim-buffergator'   "buffer management
		Plugin 'mhinz/vim-signify'               "version control system gutter info
		Plugin 'scrooloose/nerdtree'             "file manager
		Plugin 'tpope/vim-fugitive'              "git awesomeness
		Plugin 'tpope/vim-surround'              "quotes replacement made easy
		Plugin 'directionalWindowResizer'        "resize windows with simple hotkeys
		"Plugin 'scrooloose/nerdcommenter'        "comment manager
		"Plugin 'tpope/vim-tbone'                 "tmux support
		"Plugin 'kien/ctrlp.vim'                  "some quick file accessing goodness
		"Plugin 'vimacs'                          "it's emacs, in vim insert mode

		" IDE like features
		"Plugin 'jiangmiao/auto-pairs'            "automatically place closing bracket / quote
		"Plugin 'majutsushi/tagbar'               "class / module browser
		"Plugin 'msanders/snipmate.vim'           "snippets support
		"Plugin 'xolox/vim-misc'                  "deps for lua-ftplugin
		"Plugin 'xolox/vim-lua-ftplugin'          "lua stuff (very slow)

		" colorschemes
		Plugin 'morhetz/gruvbox'
		Plugin 'MichaelMalick/vim-colors-bluedrake'
		Plugin 'romainl/Apprentice'

		" syntax highlight plugins
		Plugin 'puppetlabs/puppet-syntax-vim'
		Plugin 'nagios-syntax'
		silent! call vundle#end()

		" auto-pairs options
		"let g:AutoPairsShortcutToggle='<Leader>p'

		" easymotion options
		let g:EasyMotion_do_mapping=0
		let g:EasyMotion_smartcase=1
		nmap s <Plug>(easymotion-s)
		map <Leader>j <Plug>(easymotion-j)
		map <Leader>k <Plug>(easymotion-k)

		" airline options
		let g:airline_symbols={}
		let g:airline_symbols.whitespace='!'
		let g:airline_powerline_fonts=1

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
	endif

	let g:gruvbox_italic=0
	let g:gruvbox_underline=0
	colorscheme gruvbox
else
	colorscheme elflord
endif

syntax on

filetype plugin on
