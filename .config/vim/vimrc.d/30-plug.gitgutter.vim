" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/git.vim
" └───────────────────────── ─ ─   ─

" ····· option
let g:gitgutter_enabled = 0
let g:gitgutter_override_sign_column_highlight = 0

" ····· style
let g:gitgutter_sign_added                     = '▍'
let g:gitgutter_sign_modified                  = '▍'
let g:gitgutter_sign_removed                   = '▍'
let g:gitgutter_sign_removed_first_line        = '▍'
let g:gitgutter_sign_modified_removed          = '▍'

" ····· mapping
nmap    <silent><leader>gg         :GitGutterToggle<CR>
