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

" set indentation options for specific file types
autocmd FileType ruby setlocal sts=2 sw=2 expandtab
autocmd FileType eruby setlocal sts=2 sw=2 expandtab
autocmd FileType puppet setlocal sts=2 sw=2 expandtab
autocmd FileType python setlocal sts=4 sw=4 expandtab

" maps
nmap <Space> <C-W>
nmap j gj
nmap k gk

" still have to deal with old vim versions :<
if v:version >= 703
	set helplang=en

	set list
	set listchars=tab:\|\ ,trail:*,nbsp:x

	" enable case indentation
	let g:sh_indent_case_labels=1

	" plugins
	if filereadable(expand("$HOME/.vim/bundle/Vundle.vim/autoload/vundle.vim"))
		filetype off
		set rtp+=~/.vim/bundle/Vundle.vim/
		silent! call vundle#begin()
		Plugin 'gmarik/Vundle.vim'		"plugin manager

		" general plugins
		" from github.com
		Plugin 'bling/vim-airline'		"stylish info display
		Plugin 'bling/vim-bufferline'		"stylish buffer display
		Plugin 'jeetsukumaran/vim-buffergator'	"buffer management
		Plugin 'kien/ctrlp.vim'			"some quick file accessiong goodness
		Plugin 'mbbill/undotree'		"undo buffer manager
		Plugin 'mhinz/vim-signify'		"version control system gutter info
		Plugin 'msanders/snipmate.vim'		"snippets support
		Plugin 'scrooloose/nerdcommenter'	"comment manager
		Plugin 'scrooloose/nerdtree'		"file manager
		Plugin 'scrooloose/syntastic'		"syntax checker
		Plugin 'tpope/vim-fugitive'		"git awesomeness
		Plugin 'tpope/vim-surround'		"quotes replacement made easy
		Plugin 'tpope/vim-tbone'		"tmux support
		" from vim.sf.net
		Plugin 'directionalWindowResizer'	"resize windows with simple hotkeys
		Plugin 'vcscommand.vim'			"shortcuts for vcs

		" colorscheme ...
		Plugin 'vdrandom/forked-solarized.vim'	"solarized
		Plugin 'nanotech/jellybeans.vim'	"jellybeans
		Plugin 'tomasr/molokai'			"molokai

		" syntax highlight plugins
		Plugin 'dag/vim-fish'			"fish
		Plugin 'puppetlabs/puppet-syntax-vim'	"puppet
		Plugin 'nagios-syntax'			"nagios / icinga
		silent! call vundle#end()

		" airline options
		if &t_Co > 88 || has("gui_running")
			let g:airline_powerline_fonts = 1
		endif
		let g:airline_symbols = {}
		let g:airline_symbols.whitespace = '!'

		" bufferline options
		let g:bufferline_show_bufnr = 0

		" signify options
		let g:signify_vcs_list = [ 'svn', 'git' ]
		let g:signify_sign_change = '~'

		" nerdtree options
		let NERDTreeDirArrows=0
		map <C-W>. :NERDTreeToggle<cr>
	endif
endif

" set color scheme depending on the terminal capabilities
if &t_Co > 88 || has("gui_running")
	colorscheme solarized
else
	colorscheme elflord
endif

" gvim stuff
if has("gui_running")
	let g:solarized_italic=0
	let g:solarized_bold=0
	let NERDTreeDirArrows=1
	set guioptions=aegimLl
	set mouse=a
	set guifont=Terminus\ 11
	set novb
	map <S-Insert> <MiddleMouse>
	map! <S-Insert> <MiddleMouse>
endif

syntax on
filetype plugin indent on
