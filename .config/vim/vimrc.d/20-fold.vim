" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/fold.vim
" └───────────────────────── ─ ─   ─

" ····· options
set foldmethod=marker
set foldmarker={{{,}}}
set foldlevel=99
set viewoptions-=options

" ····· save folds
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * if expand("%") != "" | mkview | endif
  autocmd BufWinEnter * if expand("%") != "" | loadview | endif
  " au BufWritePost,BufLeave,WinLeave ?* mkview
  " au BufWinEnter ?* silent loadview
augroup END

" ····· folding newstyle, steal from:
"                  https://gist.github.com/sjl/3360978
function! MyFoldText()
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart
    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - strdisplaywidth(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" ····· mapping
vmap     <leader>za :fo<cr>
