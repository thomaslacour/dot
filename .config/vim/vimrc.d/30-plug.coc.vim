" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/coc.vim
" └───────────────────────── ─ ─   ─

" ····· install usefull coc-extensions
" if $USER != 'root'
"   if !empty(glob($VIMHOME.'plugged/plug.coc'))
"     :CocInstall coc-pyright coc-json
"   endif
" endif


" ····· respect xdg specification
let g:coc_config_home=$XDG_CONFIG_HOME.'/coc'


" ····· use TAB for completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" ····· solve pyright issue
" https://github.com/neoclide/coc.nvim/wiki/Using-workspaceFolders#resolve-workspace-folder
"
autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
set sessionoptions+=globals

