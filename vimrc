set nocompatible
set background=dark
set backspace=indent,eol,start
set clipboard=exclude:.*
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
set termencoding=utf-8
" scroll before reaching the first / final line
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
" disable bell
set noerrorbells visualbell t_vb=

" enforce 256 colours for ssh connections and VTE
if $TERM == 'xterm' || $TERM == 'screen' || exists("$SSH_CLIENT")
	let &t_Co=256
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
nmap <Space> <C-W>
noremap <F1> <Esc>
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
	set listchars=tab:\|.,trail:*,nbsp:x
	nnoremap <Leader>n :setlocal number!<CR>
	nnoremap <Leader>l :setlocal list!<CR>

	" enable case indentation
	let g:sh_indent_case_labels=1

	" plugins
	if filereadable(expand("$HOME/.vim/bundle/Vundle.vim/autoload/vundle.vim"))
		filetype off
		set rtp+=~/.vim/bundle/Vundle.vim/
		silent! call vundle#begin()
		Plugin 'gmarik/Vundle.vim'              "plugin manager

		" general plugins
		Plugin 'bling/vim-airline'              "stylish info display
		Plugin 'bling/vim-bufferline'           "stylish buffer display
		Plugin 'jeetsukumaran/vim-buffergator'  "buffer management
		Plugin 'mhinz/vim-signify'              "version control system gutter info
		Plugin 'scrooloose/nerdcommenter'       "comment manager
		Plugin 'scrooloose/nerdtree'            "file manager
		Plugin 'Shougo/unite.vim'               "fuzzy file open
		Plugin 'tpope/vim-fugitive'             "git awesomeness
		Plugin 'tpope/vim-surround'             "quotes replacement made easy
		Plugin 'tpope/vim-tbone'                "tmux support
		"Plugin 'kien/ctrlp.vim'                 "some quick file accessing goodness

		" IDE like features
		Plugin 'davidhalter/jedi-vim'           "python autocompletion
		Plugin 'jiangmiao/auto-pairs'           "automatically place closing bracket / quote
		Plugin 'majutsushi/tagbar'              "class / module browser
		Plugin 'msanders/snipmate.vim'          "snippets support
		Plugin 'nvie/vim-flake8'                "python checking with flake8
		Plugin 'scrooloose/syntastic'           "syntax checker
		"Plugin 'klen/python-mode'               "python IDE stuff
		"Plugin 'xolox/vim-misc'                 "deps for lua-ftplugin
		"Plugin 'xolox/vim-lua-ftplugin'         "lua stuff (very slow)
		"Plugin 'vimacs'                         "it's emacs, in vim insert mode

		" from vim.sf.net
		Plugin 'directionalWindowResizer'       "resize windows with simple hotkeys

		" colorscheme ...
		Plugin 'vdrandom/forked-solarized.vim'  "solarized
		Plugin 'morhetz/gruvbox'                "gruvbox
		"Plugin 'whatyouhide/vim-gotham'         "gotham
		"Plugin 'vim-scripts/strange'            "strange
		"Plugin 'chriskempson/base16-vim'        "base16 variety
		"Plugin 'tomasr/molokai'                 "molokai

		" syntax highlight plugins
		Plugin 'puppetlabs/puppet-syntax-vim'   "puppet
		Plugin 'nagios-syntax'                  "nagios / icinga
		silent! call vundle#end()

		" airline options
		let g:airline_symbols={}
		let g:airline_symbols.whitespace='!'
		let g:airline_powerline_fonts=1

		" bufferline options
		let g:bufferline_show_bufnr=0

		" signify options
		let g:signify_vcs_list=[ 'svn', 'git' ]
		let g:signify_sign_change='~'

		" nerdtree options
		let NERDTreeDirArrows=0
		map <Leader>, :NERDTreeToggle<CR>

		" buffergator options
		map <Leader><Tab> :BuffergatorToggle<CR>

		" tagbar options
		map <Leader>. :TagbarToggle<CR>
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
		let g:gruvbox_italic=0
		let g:gruvbox_underline=0
		colorscheme gruvbox
	elseif &t_Co > 87
		let g:solarized_bold=0
		let g:solarized_italic=0
		let g:solarized_underline=0
		let g:solarized_visibility='low'
		let g:solarized_termtrans=1
		colorscheme solarized
	endif
else
	colorscheme elflord
endif

syntax on
filetype plugin indent on
