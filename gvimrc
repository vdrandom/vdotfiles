" Iosevka Term ss10
if has('win32')
    set guifont=Fantasque_Sams_Mono:h12
else
    set guifont=Fantasque\ Sans\ Mono\ 12
endif
let g:lightline = { 'colorscheme': 'solarized', }
set guiheadroom=0 guioptions=aei mouse=a
set noerrorbells visualbell t_vb=
set guicursor=a:blinkon0,a:block,i:ver1-Cursor/lCursor,r:hor1-Cursor/lCursor
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
