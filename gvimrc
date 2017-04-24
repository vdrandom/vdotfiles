" solarized for gvim
highlight Cursor guibg=#dc322f guifg=#fdf6e3
set guioptions=aeilL
set mouse=a
if has('win32')
    set guifont=Fantasque_Sans_Mono:h11
else
    set guifont=Fantasque\ Sans\ Mono\ 11
endif
set noeb vb t_vb=
set guicursor=a:block                   "block cursor by default
set guicursor+=i:ver1-Cursor/lCursor    "i-beam for insert mode
set guicursor+=r:hor1-Cursor/lCursor    "underline for replace
set guicursor+=a:blinkon0               "and none of them should blink
set guiheadroom=0
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
