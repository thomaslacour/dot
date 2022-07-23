" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/theme.vim
" └───────────────────────── ─ ─   ─


let $VIM_COLOR='space_vim_theme'


" ····· enable syntax or not
function! _SyntaxToggle()
  if exists("g:syntax_on")
    syntax off
  else
    syntax enable
  endif
  :call _SetTheme()
endfunction
command SyntaxToggle :call _SyntaxToggle()
nnoremap <leader>S :SyntaxToggle<CR>


if exists("g:syntax_on")
  try
    colorscheme $VIM_COLOR
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
  endtry
endif


function! _SetTheme()
  " ····· see tab and space character but not endline
  exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~,extends:>,precedes:<"
  set list

  " ····· allow color schemes to do bright colors without forcing bold.
  if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
  endif

  " ····· fillchars  ············
  set fillchars+=vert:\│ " windows
  set fillchars+=fold:·  " folding

  " ····· cursorline
  setlocal nocursorline

  " ····· cursor in magenta
  " silent !echo -ne "\033]12;magenta\007"

  " ····· cursor shape change with mode
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[1 q"

  " ····· restore cursor at exit
  if has("autocmd")
    autocmd VimLeave * call system('printf "\e[1 q" > $TTY')
    autocmd VimLeave * silent !echo -ne "\033]112\007"
  end


  " ····· HELPER: get current word highlight group
  map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


  " ····· colorscheme
  hi       Normal                                  ctermbg=None
  hi       NonText                   ctermfg=None
  hi       Comment                                 ctermbg=none cterm=None
  hi! link EndOfBuffer               LineNr
  hi! link Folded                    Comment
  hi! link EasyMotionShade           Normal
  hi! link EasyMotionTarget          IncSearch
  hi       TabLineFill               ctermfg=none  ctermbg=none cterm=undercurl
  hi       Tabline                   ctermfg=none  ctermbg=none cterm=undercurl
  hi! link TabLineSel                Comment

  hi! link StatusLine                Comment
  hi! link StatusLineNC              Comment

  hi       StatusLine                ctermbg=255
  hi       StatusLineNC              ctermbg=255

  hi! link VemStatusLineModeInsert   StatusLine
  hi       VemStatusLineModeInsert   ctermfg=206   ctermbg=255  cterm=bold

  try
    :GitGutter
    hi     GitGutterAdd              ctermfg=253  ctermbg=none
    hi     GitGutterChange           ctermfg=none ctermbg=none
    hi     GitGutterDelete           ctermfg=163  ctermbg=none
    hi     GitGutterChangeDelete     ctermfg=187  ctermbg=none
  catch
  endtry


  " ····· highlight too large colunmn (=80) ---------------------------------->█<-- -  -
  hi Bang ctermfg=27
  match Bang /\%>79v.*\%<81v/

endfunction

" call _SetTheme()
syntax off
