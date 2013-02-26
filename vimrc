" ===========================================
" Who: Timo Sand (@deiga)
" What: .vimrc
" ===========================================

" All of the plugins are installed with Vundle from this file.
source ~/.vim/vundle.vim
"
set tags=./.tags,./.TAGS,./tags,./TAGS,tags;~,TAGS;~,.tags:~,.TAGS;

set history=50
set showmode
set viminfo='50,\"1000,:20,n~/.viminfo
set cpoptions=aABcFsmq
" Vim UI
set statusline=%-20(%F%)\ [%1*%M%*%n%R%H]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ %-20(%)%=\ l:\ %l,\ c:\ %c\ [%p%%]\ [LEN=%L]
" Text Formatting

" LaTeX Suite
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

set title           " show title in console title bar
set ttyfast         " smoother changes
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files

set noautoindent
set nosmartindent
set nocindent

set sm             " show matching braces, somewhat annoying...

" Basics {
    set nocompatible " explicitly get out of vi-compatible mode
    set noexrc " don't use local version of .(g)vimrc, .exrc
    set background=dark  " we plan to use a dark background
    if &term =~ "screen" || &term !~ "256color"
        set t_Co=256
        let g:solarized_termcolors=256
        "let g:solarized_termtrans=1
    endif
    colorscheme solarized
    syntax on " syntax highlighting on
" }

" General {
    set autochdir " always switch to the current file directory
    set backup " make backup files
    set clipboard+=unnamed " share windows clipboard
    set hidden " you can change buffers without saving
    set noerrorbells " don't make noise
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png,*.class
    set wildmode=list:longest,full " turn on wild mode huge list
" }

" Vim UI {
    set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you
                   " search phrase
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines
                     " betweens rows
    set list " we do what to show tabs, to ensure we get them
              " out of my files
    set matchtime=5 " how many tenths of a second to blink
                     " matching brackets for
    set nohlsearch " do not highlight searched for phrases
    set nostartofline " leave my cursor where it was
    set novisualbell " don't blink
    set number " turn on line numbers
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid
                         " 'press a key' prompt
    set sidescrolloff=10 " Keep 5 lines at the size
    "set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current
    "              | | | | |  |   |      |  |     |       column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in
    "              | | | | |  |   |          square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
" }

" Text Formatting/Layout {
    set completeopt= " don't use a pop up menu for completions
    set expandtab " no real tabs please!
    set formatoptions=rq " Automatically insert comment leader on return,
                          " and let gq format comments
    set ignorecase " case insensitive by default
    set infercase " case inferred by default
    set nowrap " do not wrap line
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set shiftwidth=4 " auto-indent amount when using cindent,
                      " >>, << and stuff like that
    set softtabstop=4 " when hitting tab or backspace, how many spaces
                       "should a tab be (see expandtab)
    set tabstop=8 " real tabs should be 8, and they will show with
                   " set list on
" }

" All hotkeys, not depedant on plugins, are bound here.
source ~/.vim/bindings.vim

" Auto commands.
source ~/.vim/autocmds.vim
