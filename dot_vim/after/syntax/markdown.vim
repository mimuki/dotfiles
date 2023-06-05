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

syntax match h4Sym /^####\s\?/ nextgroup=h4Tex conceal
syntax match h4Tex /.\+/ contained
highlight h4Sym ctermfg=2 cterm=bold 
highlight h4Tex ctermfg=2 cterm=bold

syntax match h5Sym /^#####\s\?/ nextgroup=h5Tex conceal
syntax match h5Tex /.\+/ contained
highlight h5Sym ctermfg=3 cterm=bold 
highlight h5Tex ctermfg=3 cterm=bold

syntax match h6Sym /^######\s\?/ nextgroup=h6Tex conceal
syntax match h6Tex /.\+/ contained
highlight h6Sym ctermfg=1 cterm=bold 
highlight h6Tex ctermfg=1 cterm=bold
