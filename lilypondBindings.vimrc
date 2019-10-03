set nocompatible
set number
set showmode
let g:playback_on=0
let g:mid_command = "timidity --config-file=./timidity_custom.cfg"

function! Playscore()
    if g:playback_on == 0
        echom "Playback..."
        let g:playback_on = 1
        execute "!" . g:mid_command . " " . shellescape('%:r') . ".midi"
    " else
    "     echom "Stop playback"
    "     exe '!pkill timidity'<CR>
    "     let g:playback_on = 0
    endif
endfunction

map <buffer><F5> :w <bar> exe '!lilypond --output '.shellescape('%:r').' '.shellescape('%')<CR>
map <buffer><F6> :w <bar> exe '!SDL_NOMOUSE=1 green '.shellescape('%:r').'.pdf'<CR>
map <buffer><F7> :w <bar> :call Playscore()<CR>
