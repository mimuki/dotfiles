setlocal nonumber       " No line numbers
setlocal showbreak=\    " Wrap-broken line prefix

setlocal textwidth=0 " Don't hard new line
setlocal conceallevel=2 " Hide formatting stuff like the # of headings

autocmd VimEnter * Goyo
