augroup filetypedetect
"au BufNewFile,BufRead *.wiki setf Wikipedia
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  call s:FThtml()
"au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  setf htmldjango

" Distinguish between HTML, XHTML and Django
func! s:FThtml()
  let n = 1
  while n < 10 && n < line("$")
    if getline(n) =~ '\<DTD\s\+XHTML\s'
      setf xhtml
      return
    endif
    if getline(n) =~ '{%\s*\(extends\|block\|load\|macro\|for\|if\)\>'
      setf htmldjango
      return
    endif
    let n = n + 1
  endwhile
  setf html
endfunc
augroup END
