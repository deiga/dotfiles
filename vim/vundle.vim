" ----------------------------------------
" Vundle
" ----------------------------------------

set nocompatible " be iMproved
filetype off     " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

" ---------------
" Plugin Bundles
" ---------------


" Sensible vimrc defaults
Bundle 'tpope/vim-sensible'

" Fuzzy file opener
Bundle 'kien/ctrlp.vim'

" changing surrounding characters
Bundle 'tpope/vim-surround'

" Gist!
Bundle 'mattn/gist-vim'

" Vim Markdown runtime files
Bundle 'tpope/vim-markdown'

" Syntax for nginx
Bundle 'mutewinter/nginx.vim'

" Search helper
Bundle 'henrik/vim-indexed-search'

" Language additions
"   Ruby
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-bundler'

"   JavaScript
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'leshill/vim-json'

"   HTML
Bundle 'othree/html5.vim'
Bundle 'indenthtml.vim'
Bundle 'mattn/emmet-vim'

"   XML
Bundle 'othree/xml.vim'

" Robot Framework
Bundle 'mfukar/robotframework-vim'

" Utilities
Bundle 'scrooloose/nerdcommenter'

filetype plugin indent on
