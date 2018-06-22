fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
        set ttymouse=sgr
    endif
    if &mouse == ""
        let &mouse = s:old_mouse
        echo "mouse enabled (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "mouse disabled"
    endif
endfunction
noremap <Leader>m :call <SID>ToggleMouse()<CR>
