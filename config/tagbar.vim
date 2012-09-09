let g:tagbar_width = 30
nmap tb :TagbarToggle<cr>

let g:tagbar_type_tex = {
            \ 'ctagstype' : 'latex',
            \ 'kinds'     : [
            \ 's:sections',
            \ 'g:graphics:1',
            \ 'l:labels:1',
            \ 'r:refs:1',
            \ 'p:pagerefs:1'
            \ ],
            \ 'sort'    : 0
            \ }

let g:tagbar_type_nc = {
            \ 'ctagstype' : 'nesc',
            \ 'kinds'     : [
            \ 'd:definition',
            \ 'f:function',
            \ 'c:command',
            \ 'a:task',
            \ 'e:event'
            \ ],
            \ }
