augroup filetypedetect
"au BufNewFile,BufRead *.wiki setf Wikipedia
au BufNewFile,BufRead *.nc setf nc
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  call s:FThtml()
au BufNewFile,BufRead *.py  call s:FDjango()
"au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  setf htmldjango
au BufRead,BufNewFile */etc/nginx/conf/* set ft=nginx
" Distinguish between HTML, XHTML and Django
func! s:FThtml()
  let n = 1
  while n < 10 && n < line("$")
    if getline(n) =~ '\<DTD\s\+XHTML\s'
      setf xhtml
      return
    endif
    if getline(n) =~ '{%\s*\(extends\|block\|load\|macro\|for\|if\)\>'
      setf html
      set syntax=htmldjango
      return
    endif
    let n = n + 1
  endwhile
  setf html
endfunc

func! s:FDjango()
  let n = 1
  while n < 10 && n < line("$")
    if getline(n) =~ '.*django.*'
      setf python.django
      return
    endif
    let n = n + 1
  endwhile
  setf python
endfunc
augroup END
