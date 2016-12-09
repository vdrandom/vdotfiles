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
        "plugin manager
        Plug 'junegunn/vim-plug'

        " general plugins
        Plug 'Lokaltog/vim-easymotion'         "easy motion
        Plug 'directionalWindowResizer'        "resize windows with simple hotkeys
        Plug 'jeetsukumaran/vim-buffergator'   "buffer management
        Plug 'junegunn/vim-easy-align'         "aligning
        Plug 'mhinz/vim-signify'               "version control system gutter info
        Plug 'nvie/vim-togglemouse'            "hotkey to toggle mouse
        Plug 'vim-airline/vim-airline'         "airline
        Plug 'vim-airline/vim-airline-themes'  "themes for airline
        Plug 'wincent/command-t'               "fuzzy file search
        Plug 'tpope/vim-fugitive'              "moar git awesomeness

        " python, uncomment when needed
        "Plug 'neomake/neomake'                 "linter
        "Plug 'davidhalter/jedi-vim'            "python support
        "Plug 'ervandew/supertab'               "TAB autocompletion

        " colorschemes
        Plug 'cocopon/iceberg.vim'
        Plug 'lifepillar/vim-solarized8'
        Plug 'KeitaNakamura/neodark.vim'
        Plug 'jonathanfilip/vim-lucius'
        Plug 'chriskempson/base16-vim'

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
        let g:airline_exclude_preview=1
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
        nmap <Leader>i :Neomake<CR>
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
    endif

    " gvim and colorschemes related stuff
    if has("gui_running")
        set guioptions=aegimLl
        set mouse=a
        set guifont=Fantasque\ Sans\ Mono\ 11
        set novb
        set guicursor=a:block                   "block cursor by default
        set guicursor+=i:ver1-Cursor/lCursor    "i-beam for insert mode
        set guicursor+=r:hor1-Cursor/lCursor    "underline for replace
        set guicursor+=a:blinkon0               "and none of them should blink
        set guiheadroom=0
        colorscheme iceberg
        map <S-Insert> <MiddleMouse>
        map! <S-Insert> <MiddleMouse>
    elseif (has("nvim") || v:version >= 800) && $TERM != 'screen'
        " fix tmux and st
        set t_8f=[38;2;%lu;%lu;%lum
        set t_8b=[48;2;%lu;%lu;%lum
        set termguicolors
        set mouse=a
        let g:airline_theme='neodark'
        colorscheme iceberg
    else
        set mouse=
        colorscheme solarized8_light
    endif
else
    colorscheme default
endif

syntax on

filetype plugin on
