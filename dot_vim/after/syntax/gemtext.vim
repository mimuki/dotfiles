" Regex
" Custom headings

" Match start of line, a literal #, then zero or one space
" Ideally this would be * but for some reason that breaks stuff
syntax match h1Sym /^#\s\?/ nextgroup=h1Tex conceal
" Match anything after that
syntax match h1Tex /.\+/ contained
highlight h1Sym ctermfg=5 cterm=bold 
highlight h1Tex ctermfg=5 cterm=bold

syntax match h2Sym /^##\s\?/ nextgroup=h2Tex conceal
syntax match h2Tex /.\+/ contained
highlight h2Sym ctermfg=4 cterm=bold 
highlight h2Tex ctermfg=4 cterm=bold

syntax match h3Sym /^###\s\?/ nextgroup=h3Tex conceal
syntax match h3Tex /.\+/ contained
highlight h3Sym ctermfg=6 cterm=bold 
highlight h3Tex ctermfg=6 cterm=bold

" Links
" Find the link indicator
syntax match linkSym /^=>\s\?/ conceal nextgroup=linkDescribed, linkUndescribed
" Find any text followed by a space (this will be the URL with a space for its
" description text
syntax match linkDescribed /\S\+\s/ conceal contained nextgroup=linkDescription
" Or, find any text with no trailing space (this will be a URL with no description)
syntax match linkUndescribed /\S\+$/ contained 
"Find any text until the end of the line. (this will be the descirption)
syntax match linkDescription /\S.*$/ contained
highlight linkSym ctermfg=6
highlight linkDescribed ctermfg=6
highlight linkUndescribed ctermfg=6
highlight linkDescription ctermfg=6

" Don't underline any links
highlight LinkURL cterm=none

highlight Quote ctermfg=2 cterm=italic
