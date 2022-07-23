" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/python.vim
" └───────────────────────── ─ ─   ─

let $IPYTHONCMD='/usr/bin/ipython3 --colors="Neutral" --no-banner --no-confirm-exit --autoindent'

set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" let g:repl_position = 3
" let g:repl_unhide_when_send_lines = 1
" let g:repl_console_name = 'ZYTREPL'
" let g:repl_program = {
"       \   'python':  ['ipython3 --colors="Neutral" --no-banner --no-confirm-exit --autoindent'],
"       \   'default': ['bash -l'],
"       \   'vim':     ['vim -e'],
"       \}

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix


" ····· mapping!
nnoremap <leader><c-p> :call REPLToggleVisible()<cr>

" let g:repl_is_open = 1
" function! REPLToggleVisible()
"   if g:repl_is_open
"     :REPLHide
"     let g:repl_is_open = 0
"   else
"     :REPLUnhide
"     let g:repl_is_open = 1
"   endif
" endfunction

" nnoremap <silent> <F10>         :REPLToggle<Cr>
" nnoremap <silent> <leader>e     :REPLSendSession<Cr>



let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = "<leader>p"





" ····· syn and highlights
scriptencoding utf-8

autocmd BufRead,BufNewFile  *.py :call Pythonsyn()

function! Pythonsyn()
  syn match pyFancyOperator "<=" conceal cchar=≤
  syn match pyFancyOperator "->" conceal cchar=→
  syn match pyFancyOperator ">=" conceal cchar=≥
  syn match pyFancyOperator "=\@<!===\@!" conceal cchar=≡
  syn match pyFancyOperator "!=" conceal cchar=≢
  syn match pyFancyOperator "\<\%(\%(math\|np\|numpy\)\.\)\?sqrt\>" conceal cchar=√
  syn match pyFancyKeyword "\<\%(\%(math\|np\|numpy\)\.\)\?pi\>" conceal cchar=π
  syn match pyFancyOperator " \* " conceal cchar=∙
  syn match pyFancyOperator " // " conceal cchar=÷
  syn match pyFancyOperator "@" conceal cchar=∙
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)1\>" conceal cchar=¹
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)2\>" conceal cchar=²
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)3\>" conceal cchar=³
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)4\>" conceal cchar=⁴
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)5\>" conceal cchar=⁵
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)6\>" conceal cchar=⁶
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)7\>" conceal cchar=⁷
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)8\>" conceal cchar=⁸
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)9\>" conceal cchar=⁹
  syn match pyFancyOperator "\( \|\)\*\*\( \|\)n\>" conceal cchar=ⁿ

  syn keyword pyFancyType list int float str set dict bool
  syn match   pyFancyType "\<\%(\%(pandas\|pd\)\.\)\?DataFrame\>"


  syn keyword Todo contained TODO FIXME XXX NOTE
  syn region pyFancyComment start=/#/ end=/$/ contains=Todo
  syn region pyFancyString start=/"/ end=/"/ contains=PyFancyUnderscore
  syn region pyFancyString start=/"""/ end=/"""/
  syn region pyFancyString start=/'/ end=/'/ contains=PyFancyUnderscore

  syn region pyFancyPreproc start=/import/ end=/$/ contains=pyFancyImport
  syn region pyFancyPreproc start=/from/ end=/$/
  " syn match pyFancyImport "import" contained
  " hi  link pyFancImport Preproc
  " hi pyFancyImport cterm=underline

  syn region pyFancyTest start=/#\s*==.*/ end=/$/

  syn keyword pyFancyFunction def for class while if with lambda break else try except
  syn keyword pyFancyStatement None True False
  " syn keyword pyFancyOperator not conceal cchar=¬
  syn match pyFancyOperator ":=" conceal cchar=←
  syn keyword pyFancyOperator pass conceal cchar=…
  syn keyword pyFancyOperator in conceal cchar=∈
  syn match pyFancyUnderscore "__" conceal cchar=＿
  syn match pyFancyOperator "^\s*return" contains=return
  syn match return "return" contained conceal cchar=↳
  hi! link return pyFancyOperator
  syn keyword pyFancyOperator "not in" conceal cchar=∉
  syn keyword pyFancyOperator or conceal cchar=∨
  syn match pyFancyOperator "|" conceal cchar=∨
  syn keyword pyFancyOperator and conceal cchar=∧
  syn match pyFancyOperator "&" conceal cchar=∧
  syn keyword pyFancyOperator sum conceal cchar=∑
  syn keyword pyFancyBuiltin all conceal cchar=∀
  syn keyword pyFancyBuiltin any conceal cchar=∃

  " syn region  pyFancyTest start="if __name__" end=":$"

  " syn match pyFancyComment /# --* .*/ contains=hline
  " syn match pyFancyUnderscore "--" conceal cchar=⎯

  hi Todo ctermfg=212

  hi Visual ctermfg=212 term=undercurl ctermbg=none

  hi link pyFancyPreproc Preproc
  hi link pyFancyStatement Statement
  hi link pyFancyStatementTrue pyFancyStatement
  hi link pyFancyStatementFalse pyFancyStatement
  hi! link Operator Statement

  hi link pyFancyType Type
  hi pyFancyType ctermfg=89
  hi pyFancyFunction cterm=bold
  hi link pyFancyKeyword Keyword
  hi link pyFancyBuiltin Builtin
  hi link pyFancySpecial Keyword
  hi link pyFancyOperator Operator
  hi link pyFancyFunction Function

  hi pyFancyComment cterm=italic ctermfg=239
  hi pyFancyString cterm=italic

  hi pyFancyTest ctermfg=6

  " hi! link Conceal Operator

  hi! link pyFancyUnderscore Normal

  hi pyFancyMathOperator ctermfg=3

  " handle function name FCall and its argu FCallKeyword
  " syn region FCall matchgroup=FName start='[[:alpha:]_]\i*\s*(' end=')' contains=FCall,FCallKeyword
  " syn match FCallKeyword /\i*\ze\s*=[^=]/ contained

  " enable the concealing on every line that is not the current cursor line
  set conceallevel=1

  " always conceal normal, visual, insert, and command
  set concealcursor=c
endfunction






























" let $FOO=0
" call system('rm $foo')
"
" func! RunPython(mode)
"   if &filetype=="python"
"     if $FOO==1
"     else
"       let $FOO=1
"       :FloatermKill --name=repl
"       :FloatermNew! --silent --width=0.5 --wintype=vsplit --name=repl $IPYTHONCMD  && export FOO=0 > /dev/null > 2&>1 && exit
"     endif
"     if a:mode=="n"
"       :FloatermSend --name=repl \%run '%:p'
"     elseif a:mode=="V"
"       :'<,'>FloatermSend --name=repl
"     endif
"     try
"       :FloatermShow --name=repl
"     catch
"       let $FOO=0
"     endtry
"   endif
" endfun
"
" augroup REPL
"   au!
"   au FileType python nmap     <silent> <leader><c-p> :call RunPython("n")<cr><c-w>w
"   au FileType python vmap     <silent> <leader><c-p> :call RunPython("v")<cr><c-w>w
"   au FileType python vnoremap <silent> <leader>w     vip :call RunPython("v")<cr>
" augroup END
