" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/netwr.vim
" └───────────────────────── ─ ─   ─
" Netwr is the builtin file browser


" let g:loaded_netrwPlugin=1    " assign to not load
let g:netrw_banner=0           " remove annoying banner
let g:netrw_liststyle=3        " tree view
let g:netrw_dirhistmax = 0
let g:NetrwIsOpen=0

" ····· toogle the file browser
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
        vertical resize 30
    endif
endfunction

" ····· mapping
noremap <silent> <leader>, :call ToggleNetrw()<CR>

