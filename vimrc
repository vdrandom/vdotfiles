if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
let &cpo=s:cpo_save
unlet s:cpo_save
set nocompatible
set backspace=indent,eol,start
set nobackup
set history=50
set ruler
set showcmd
set incsearch
set background=dark
set noexpandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set hlsearch
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set termencoding=utf-8
set number
set laststatus=2
set ignorecase
set smartcase
set clipboard=exclude:.*
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set foldmethod=marker
" disable bell
set noerrorbells visualbell t_vb=

" enforce 256 colours for ssh connections and VTE
if $TERM == 'xterm' || $TERM == 'screen' || exists("$SSH_CLIENT")
	let &t_Co=256
endif

" set indentation options for specific file types
autocmd FileType python setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd BufNewFile *.zsh 0put =\"#!/usr/bin/env zsh\<nl>\"|$
autocmd BufNewFile *.lua 0put =\"#!/usr/bin/env lua\<nl>\"|$
autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\"|$
autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$
autocmd BufNewFile *.pl 0put =\"#!/usr/bin/env perl\<nl>\use strict;\<nl>\use warnings;\<nl>\use feature 'say';\<nl>\"|$

" maps
nmap <Space> <C-W>
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" still have to deal with old vim versions :<
if v:version >= 700
	set helplang=en
	set modeline

	set list
	set listchars=tab:\|.,trail:*,nbsp:x
	nnoremap <leader>l :setlocal list!<cr>
	nnoremap <leader>r :setlocal number!<cr>

	" enable case indentation
	let g:sh_indent_case_labels=1

	" plugins
	if filereadable(expand("$HOME/.vim/bundle/Vundle.vim/autoload/vundle.vim"))
		filetype off
		set rtp+=~/.vim/bundle/Vundle.vim/
		silent! call vundle#begin()
		Plugin 'gmarik/Vundle.vim'              "plugin manager

		" general plugins
		" from github.com
		Plugin 'bling/vim-airline'              "stylish info display
		Plugin 'bling/vim-bufferline'           "stylish buffer display
		Plugin 'bhiestand/vcscommand'           "shortcuts for vcs
		Plugin 'jeetsukumaran/vim-buffergator'  "buffer management
		Plugin 'kien/ctrlp.vim'                 "some quick file accessing goodness
		Plugin 'mhinz/vim-signify'              "version control system gutter info
		Plugin 'msanders/snipmate.vim'          "snippets support
		Plugin 'scrooloose/nerdcommenter'       "comment manager
		Plugin 'scrooloose/nerdtree'            "file manager
		Plugin 'scrooloose/syntastic'           "syntax checker
		Plugin 'tpope/vim-fugitive'             "git awesomeness
		Plugin 'tpope/vim-surround'             "quotes replacement made easy
		Plugin 'tpope/vim-tbone'                "tmux support
		"Plugin 'xolox/vim-misc'                 "deps for lua-ftplugin
		"Plugin 'xolox/vim-lua-ftplugin'         "lua stuff

		" from vim.sf.net
		Plugin 'directionalWindowResizer'       "resize windows with simple hotkeys

		" colorscheme ...
		Plugin 'vdrandom/forked-solarized.vim'  "solarized
		Plugin 'cocopon/iceberg.vim'            "iceberg
		Plugin 'morhetz/gruvbox'                "gruvbox
		Plugin 'nanotech/jellybeans.vim'        "jellybeans
		Plugin 'whatyouhide/vim-gotham'         "gotham
		Plugin 'vim-scripts/strange'            "strange

		" syntax highlight plugins
		Plugin 'dag/vim-fish'                   "fish
		Plugin 'puppetlabs/puppet-syntax-vim'   "puppet
		Plugin 'nagios-syntax'                  "nagios / icinga
		silent! call vundle#end()

		" airline options
		let g:airline_symbols = {}
		let g:airline_symbols.whitespace = '!'
		let g:airline_powerline_fonts = 1

		" bufferline options
		let g:bufferline_show_bufnr = 0

		" signify options
		let g:signify_vcs_list = [ 'svn', 'git' ]
		let g:signify_sign_change = '~'

		" nerdtree options
		let NERDTreeDirArrows=0
		map <C-W>. :NERDTreeToggle<cr>

		" buffergator options
		map <C-W>, :BuffergatorToggle<cr>
	endif

	" gvim and colorschemes related stuff
	if has("gui_running")
		let NERDTreeDirArrows=1
		set guioptions=aegimLl
		set mouse=a
		set guifont=Terminus\ 11
		set novb
		set guicursor=a:blinkon0
		map <S-Insert> <MiddleMouse>
		map! <S-Insert> <MiddleMouse>
		colorscheme gotham
	elseif &t_Co > 87
		let g:solarized_bold=0
		let g:solarized_italic=0
		let g:solarized_underline=0
		let g:solarized_visibility='low'
		colorscheme solarized
	endif
else
	colorscheme elflord
endif

syntax on
filetype plugin indent on
