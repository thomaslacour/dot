" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/viminfo.vim
" └───────────────────────── ─ ─   ─

" set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo
"             | |    |   |   |    | |  |
"             | |    |   |   |    | |  + viminfo file path
"             | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"             | |    |   |   |    + disable 'hlsearch' loading viminfo
"             | |    |   |   + command-line history saved
"             | |    |   + search history saved
"             | |    + files marks saved
"             | + lines saved each register (old name for <, vi6.2)
"             + save/restore buffer list

" set viminfo=%,<800,'10,/50,:100,h,f0,n~/.local/share/vim/viminfo

set viminfo=%,<800,'10,/50,:100,h,f0
execute 'set viminfo+=n'.$VIMDATA.'/viminfo.'.$VIM

