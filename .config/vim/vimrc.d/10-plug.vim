" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/plug.vim
" └───────────────────────── ─ ─   ─
" plugin manager for vim. The best one.

" ····· the window position of VimPlug
let g:plug_window='botright new'

" ····· automatically install vim plug if not installed yet
if $USER != 'root'
  if empty(glob($VIMHOME.'autoload/plug.vim'))
    silent !curl -fLo $VIMHOME'autoload/plug.vim' --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null 2>&1
    if has("autocmd")
      autocmd VimEnter * silent PlugInstall --sync | source $MYVIMRC | q
    endif
  endif
endif


call plug#begin($VIMHOME.'plugged')

" ~~~~~ begin of list of plugins ~~~~~

Plug 'liuchengxu/space-vim-theme',    { 'as':'colors.space-vim', 'dir':$VIMHOME.'/color/spacevim' }
Plug 'gioele/vim-autoswap',           { 'as':'vim.autoswap' }
Plug 'easymotion/vim-easymotion',     { 'as':'vim.motion' }
Plug 'andymass/vim-matchup',          { 'as':'vim.matchup' } | let g:matchup_matchparen_deferred = 1
Plug 'tpope/vim-commentary',          { 'as':'vim.commentary' }
Plug 'junegunn/vim-easy-align',       { 'as':'vim.align' }
Plug 'sillybun/vim-repl' ,            { 'as':'vim.repl' }
Plug 'tpope/vim-surround',            { 'as':'vim.surround' }
Plug 'pacha/vem-statusline',          { 'as':'vim.statusline', 'dir':$VIMHOME.'/plugged/moonfly' }
Plug 'junegunn/goyo.vim',             { 'as':'plug.goyo' }
Plug 'airblade/vim-gitgutter',        { 'as':'plug.gitgutter'} | let g:gitgutter_enabled = 0
Plug 'voldikss/vim-floaterm',         { 'as':'plug.floaterm' } | let g:floaterm_keymap_toggle = '<F12>' | let g:floaterm_autoclose=2
" Plug 'neoclide/coc.nvim',             { 'as':'plug.coc', 'branch': 'release' }
" Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown', { 'as':'markdown' }

Plug 'github/copilot.vim',            { 'as':'plug.copilot' }

" ~~~~~ end of list of plugins ~~~~~

" ····· load plugins
call plug#end()
