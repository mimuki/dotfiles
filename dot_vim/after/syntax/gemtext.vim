" Regex
" Custom headings
syntax match headingOne '^#.*$'
syntax match headingTwo '^##.*$'
syntax match headingThree '^###.*$'
" Links
syntax match webLink '^=>\s\w*:.*$'
syntax match gemLink '^=>\s*gemini:.*$'

" Set hilighting colours
highlight headingOne   ctermfg=5 cterm=bold
highlight headingTwo   ctermfg=4 cterm=bold
highlight headingThree ctermfg=6 cterm=bold
" Don't underline any links
highlight LinkURL cterm=none
" colour number from: https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg
highlight webLink ctermfg=214
highlight gemLink ctermfg=6
highlight Quote ctermfg=2 cterm=italic

