" ----------------------------------------
" Bindings
" ----------------------------------------

" space / shift-space scroll in normal mode
noremap <S-space> <C-b>
noremap <space> <C-f>

" set leader key to comma
let mapleader = ","

map <F1> :previous<CR>  " map F1 to open previous buffer
map <F2> :next<CR>      " map F2 to open next buffer
map <silent> <C-N> :silent noh<CR> " turn off highlighted search
map <leader>v :vs $MYVIMRC<cr> " edit my .vimrc file in a split
map <leader>e :e $MYVIMRC<cr>      " edit my .vimrc file
map <leader>u :source $MYVIMRC<cr> " update the system settings from my vimrc file
"----- write out html file
map <leader>h :source $VIM/vim71/syntax/2html.vim<cr>:w<cr>:clo<cr>

" Paste mode toggle
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>

" Refactor
" Local
:nnoremap grl gdyiw[{V%:s/<C-R>"//gc<left><left><left>
" File
:nnoremap grf yiwggVG:s/<C-R>"//gc<left><left><left> 

" Commands
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':W' | :q
command WQ :Wq
command Q :execute ':q!'

" xmpfilter
autocmd FileType ruby nmap <buffer> <leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <leader>m <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <leader>m <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <leader>r <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <leader>r <Plug>(xmpfilter-run)
