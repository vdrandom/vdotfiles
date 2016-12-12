if filereadable(expand("$HOME/.vim/plugged/vim-plug/plug.vim"))
    set noshowmode
    source ~/.vim/plugged/vim-plug/plug.vim
    silent!call plug#begin('~/.vim/plugged')
    " plugin manager for self updates
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
    Plug 'sheerun/vim-polyglot'            "syntax

    " python, uncomment when needed
    "Plug 'neomake/neomake'                 "linter
    "Plug 'davidhalter/jedi-vim'            "python support
    "Plug 'ervandew/supertab'               "TAB autocompletion

    " colorschemes
    Plug 'lifepillar/vim-solarized8'

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