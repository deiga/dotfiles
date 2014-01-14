" ----------------------------------------
" Auto Commands
" ----------------------------------------

if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Filetypes (au = autocmd)
    au FileType helpfile set nonumber      " no line numbers when viewing help
    au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

    " When using mutt, text width=72
    au FileType mail,tex set textwidth=72
    au FileType cpp,c,java,sh,pl,php,asp  set autoindent
    au FileType cpp,c,java,sh,pl,php,asp  set smartindent
    au FileType cpp,c,java,sh,pl,php,asp  set cindent
    "au BufRead mutt*[0-9] set tw=72

    " Automatically chmod +x Shell and Perl scripts
    "au BufWritePost   *.sh             !chmod +x %
    "au BufWritePost   *.pl             !chmod +x %

    " File formats
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf

    " Ruby {
        " ruby standard 2 spaces, always
        au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2
        au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2
    " }
    
    " XML {
        au FileType xml set omnifunc=xmlcomplete#CompleteTags
    " }

    " Haskell {
        au FileType hs set tabstop=8
        au FileType hs set expandtab
        au FileType hs set softtabstop=4
        au FileType hs set shiftwidth=4
        au FileType hs set smarttab
        au FileType hs set shiftround
        au FileType hs set nojoinspaces
    " }

    
    " Crontab http://vim.wikia.com/wiki/Editing_crontab
    au BufEnter /private/tmp/crontab.* setl backupcopy=yes
endif
