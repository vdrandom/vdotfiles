" solarized for gvim
highlight Cursor guibg=#dc322f
set guioptions=aegimLl
set mouse=a
set guifont=Fantasque\ Sans\ Mono\ 11
set novb
set guicursor=a:block                   "block cursor by default
set guicursor+=i:ver1-Cursor/lCursor    "i-beam for insert mode
set guicursor+=r:hor1-Cursor/lCursor    "underline for replace
set guicursor+=a:blinkon0               "and none of them should blink
set guiheadroom=0
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
