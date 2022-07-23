" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/repl.vim
" └───────────────────────── ─ ─   ─
" REPL and all terminal stuff

" ----- TERMINAL

" ····· navigation
if has('terminal')
  au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif
end

" ····· use a login shell to bring .profil and .bashrc
set shell=bash\ -l

" ····· split for terminal
if has('terminal')
  map <silent> <leader>T :vertical terminal! ++kill=term ++close ++norestore<CR>
end
