set nocompatible
set number
set showmode
filetype plugin indent on
autocmd BufNewFile,BufRead *.ly set ft=lilypond
autocmd BufNewFile,BufRead *.abc set ft=abc

autocmd FileType lilypond nnoremap <buffer><F5> :w <bar> exe '!lilypond --output '.shellescape('%:r').' '.shellescape('%')<CR>
autocmd FileType lilypond,abc nnoremap <buffer><F6> :w <bar> exe '!SDL_NOMOUSE=1 green '.shellescape('%:r').'.pdf'<CR>
autocmd FileType lilypond,abc nnoremap <buffer><F7> :w <bar> exe '!timidity --config-file=./timidity_custom.cfg '.shellescape('%:r').'.midi'<CR>
autocmd FileType lilypond,abc nnoremap <buffer><F8> :w <bar> exe '!timidity --config-file=./timidity_custom.cfg '.shellescape('%:r').'.midi -Ow'<CR>

autocmd FileType abc nnoremap <buffer><F5> :w <bar> exe '!abcm2ps '.shellescape('%:p').' -O '.shellescape('%:r').'.ps' <bar> exe '!ps2pdfwr '.shellescape('%:r').'.ps '.shellescape('%:r').'.pdf' <bar> exe '!abc2midi '.shellescape('%:p').' -o '.shellescape('%:r').'.midi'<CR>
