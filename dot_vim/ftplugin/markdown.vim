setlocal nonumber       " No line numbers
setlocal showbreak=\    " Wrap-broken line prefix
setlocal conceallevel=2 " Hide formatting characters like **
setlocal textwidth=0 " Don't hard new line
" 0 (start of line)
" strftime() (do magic to get time)
" <CR> (idk)
" P (put text before the cursor)
" $ (end of line)
" a (go to insert mode, but in a way that leaves a space)
nnoremap <F5> 0"=strftime("**%I:%M %P:**\ ")<CR>P$a
autocmd VimEnter * Goyo
