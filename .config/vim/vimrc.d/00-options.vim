" ┌───────────────────────── ─ ─   ─
" │ ~/.config/vim/vimrc.d/options.vim
" └───────────────────────── ─ ─   ─

" ····· general
filetype indent on
set fileencodings=utf-8        " file encoding
set secure                     " avoid shell command with modelines
set autoindent
set backspace=indent,eol,start " make backspace behave in a sane manner
set noshowmode                 " INSERTION, VISUAL etc ...
set ruler                      " line number and column
set showcmd                    " in VISUAL show the size of the selected area
set wildmenu wildmode=list:longest,full
set scrolloff=7                " minimal number of screen lines to keep above and below the cursor
set cmdheight=1                " command height
set foldcolumn=0               " no extra margin on left
set splitright                 " default splitting
set belloff=all                " no strange character (visualbell)
set noeb vb t_vb=              " disable beep and flash
set tm=500                     " time for combination
set updatetime=500             " delay to write swap
set tw=0                       " disable autowrapping (=0)
set hidden                     " modified buffers are not abandonned
set formatoptions+=j           " remove comment introducers when joining comment lines
set lazyredraw                 " don't redraw while executing macros

" ····· buffers
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>

" ····· mouse
if has("mouse")
  silent! set ttymouse=xterm2
  set mouse=a
  set mousehide                " hide mouse when typing
  set mousemodel=popup_setpos  " popupmenu rather than selecting
endif

" ····· backup, swap, etc
" set nowritebackup              "  ... ever (nowb)
" set nobackup                   "  no backup files (nobk)
if $USER == 'root'
  set noswapfile
else
  set swapfile
endif

" ····· shift
set shiftwidth=2
set shiftround

" ····· tabs
set softtabstop=2
set expandtab
set smarttab

" ····· search
set ignorecase                 "  case insensitive search
set smartcase                  "
set infercase                  "
set incsearch                  "  moderne search
set showmatch                  "  show matching bracket
set mat=2                      "  blinking tim for bracket
set hlsearch                   "  highlight results
