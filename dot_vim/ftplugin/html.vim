" Close HTML tags in a cool and good way
" == re-indents the current line 
" (but this would move the cursor, so gi puts it back)
" the other stuff I don't undertand so well.
" https://vim.fandom.com/wiki/Auto_closing_an_HTML_tag
inoremap <lt>/ </<C-x><C-o><Esc>==gi
" Default vim syntax highlighting underlines links
" This disables it
highlight link htmlLink text
