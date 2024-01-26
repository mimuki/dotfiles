setlocal nonumber       " No line numbers
setlocal showbreak=\ \  " Wrap-broken line prefix
setlocal display+=lastline " Show as much of the last visible line as possible
                           " (Fixes the last wrapped line being hidden if it
                           " wraps offscreen)
setlocal textwidth=0 " Don't hard new line
setlocal conceallevel=2 " Hide formatting stuff like the # of headings
