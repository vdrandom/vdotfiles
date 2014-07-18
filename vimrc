if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
map <S-Insert> <MiddleMouse>
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
set helplang=en
set hlsearch
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set termencoding=utf-8
set number
set laststatus=2
set ignorecase
set smartcase
set clipboard=exclude:.*
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" set indentation options for specific file types
autocmd FileType ruby setlocal sts=2 sw=2 expandtab
autocmd FileType eruby setlocal sts=2 sw=2 expandtab
autocmd FileType puppet setlocal sts=2 sw=2 expandtab
autocmd FileType python setlocal sts=4 sw=4 expandtab
autocmd FileType lua setlocal sts=4 sw=4 expandtab

" next line in wrapped lines
nmap j gj
nmap k gk

" gvim stuff
if has("gui_running")
	set guioptions=aegimLl
	set mouse=a
	set guifont=Terminus\ 11
endif

" svndiff plugin
if filereadable(expand("$HOME/.vim/plugins/svndiff.vim"))
	source $HOME/.vim/plugins/svndiff.vim
	noremap <F3> :call Svndiff("prev")<CR>
	noremap <F4> :call Svndiff("next")<CR>
	noremap <F5> :call Svndiff("clear")<CR>
endif

" set color scheme depending on the terminal capabilities
if &t_Co < 88
	colorscheme elflord
else
	colorscheme solarized
endif

" still have to deal with old vim versions :<
if v:version >= 703
	" enable case indentation
	let g:sh_indent_case_labels=1

	" plugins
	if filereadable(expand("$HOME/.vim/bundle/Vundle.vim/autoload/vundle.vim"))
		filetype off
		set rtp+=~/.vim/bundle/Vundle.vim/
		call vundle#begin()
		Plugin 'gmarik/Vundle.vim'

		" general plugins
		Plugin 'scrooloose/nerdtree'
		Plugin 'scrooloose/syntastic'
		Plugin 'msanders/snipmate.vim'
		Plugin 'bling/vim-airline'
		Plugin 'bling/vim-bufferline'
		Plugin 'tpope/vim-surround'
		Plugin 'mbbill/undotree'
		Plugin 'jiangmiao/auto-pairs'

		" syntax highlight plugins
		Plugin 'puppetlabs/puppet-syntax-vim'
		Plugin 'vim-scripts/nagios-syntax'
		call vundle#end()
		let g:airline_powerline_fonts = 1
	elseif filereadable(expand("$HOME/.vim/autoload/pathogen.vim"))
		execute pathogen#infect()
	endif
endif

syntax on
filetype plugin indent on
