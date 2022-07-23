" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/mapping.vim
" └───────────────────────── ─ ─   ─

" ····· leader and local leader
let mapleader=";"
let maplocalleader = ",k"

" ····· Disable “Type :quit<Enter> to exit Vim” message when pressing Ctrl+C
nnoremap <C-c> <silent> <C-c>

" ····· be carefull padawan
"       https://stackoverflow.com/questions/5030164/whats-the-difference-between-ctrlc-and-ctrl
imap     <C-c> <Esc>

" ····· disable recording macros, i hit that shit to often
nnoremap q <Nop>

" ····· emergency exit
nmap     <leader>q :qa!<cr>
tmap     <leader>q <c-w>:qa!<cr>

" ····· save with sudo
command  W :execute ':silent w !sudo tee % > /dev/null' | :edit!
cmap     W!       w !sudo tee % >/dev/null

" ····· sell checking
nmap     <leader>ss    :set spell!<CR>
map      <leader>sfr   :setlocal spell spelllang=fr<CR>
map      <leader>sen   :setlocal spell spelllang=en<CR>

" ····· Omnicompletion
imap     <leader><tab> <c-x><c-o><c-p>

" ····· marks
nmap     <leader>m  :marks<cr>

" ····· save
imap     <C-S> <esc>:w<cr>a

" ····· display mapping
nmap     <space><leader>   :<c-u>map <leader><cr>
nmap     <space>g          :<c-u>map g<cr>

" ····· tabs
map      <leader>te    :tabedit <c-r>=expand("%:p:h")<cr>/
map      <leader>tc    :tabclose <cr>/

" ····· buffers
map      <leader>e     :edit <c-r>=expand("%:p:h")<cr>/
nmap     <leader>x     :close!<CR>
tmap     <leader>x     <c-w>:bd!<CR>
nmap     <leader>b     :ls<CR>
nnoremap <space>b      :b
nnoremap <leader>B     :b *.<c-r>=expand("%:e")<cr><C-Z>

" ····· Visual mapping
nnoremap  <leader>V     <c-v>

" ····· inverse V with visual block !
nnoremap v          <C-V>
nnoremap <C-V>      v
vnoremap v          <C-V>
vnoremap <C-V>      v

" ····· search
map      <leader><space> <Plug>(easymotion-sn)
omap     /               <Plug>(easymotion-tn)
map      <leader>n       <Plug>(easymotion-next)
map      <leader>p       <Plug>(easymotion-prev)
vnoremap <silent>        <leader>r :call VisualSelection('replace')<CR>
vnoremap <Leader>r       "hy:%s/<C-r>h//g<left><left>
nnoremap <Leader>r       :%s/\<<C-r><C-w>\>//g<left><left>

" ····· Disable highlight
nohls
map      <silent>      <leader>! :noh<cr>

" ····· system clipboard copy/paste
noremap  <leader>y    "*y
noremap  <leader>p    "*p
noremap  <leader>Y    "+y
noremap  <leader>P    "+p

" ····· Duplicate selection
vmap     D            y'>p

" ····· toogle mapping
nmap    <silent><leader>W          :set wrap!<CR>
nmap    <silent><silent><leader>ll :set nu! <CR>
" nmap    <silent><silent><leader>ll :set nu! cul! <CR> | hi CursorLineNr ctermbg=none
nmap    <silent><leader>G          :Goyo<CR>
nmap    <silent><leader>A          :ALEToggle<CR>

" ····· show all highlight group !
nmap    <C-h>h :so $VIMRUNTIME/syntax/hitest.vim<cr>


" ····· EasyAlign
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)
