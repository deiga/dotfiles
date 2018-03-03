" ----------------------------------------
" Vundle
" ----------------------------------------

set nocompatible " be iMproved
filetype off     " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'


" Sensible vimrc defaults
Plugin 'tpope/vim-sensible'

" Fuzzy file opener
Plugin 'kien/ctrlp.vim'

" changing surrounding characters
Plugin 'tpope/vim-surround'

" Gist!
Plugin 'mattn/gist-vim'

" Vim Markdown runtime files
Plugin 'tpope/vim-markdown'

" Syntax for nginx
Plugin 'mutewinter/nginx.vim'

" Search helper
Plugin 'henrik/vim-indexed-search'

" Language additions
"   Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'

"   JavaScript
Plugin 'pangloss/vim-javascript'
Plugin 'leshill/vim-json'

"   HTML
Plugin 'othree/html5.vim'
Plugin 'indenthtml.vim'
Plugin 'mattn/emmet-vim'

"   XML
Plugin 'othree/xml.vim'

" Robot Framework
Plugin 'mfukar/robotframework-vim'

" Utilities
Plugin 'scrooloose/nerdcommenter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-heroku'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'markcornick/vim-vagrant'
Bundle 'wakatime/vim-wakatime'

call vundle#end()

filetype plugin indent on
