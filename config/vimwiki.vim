let g:vimwiki_list=[{'path':'~/Dropbox/vimwiki',
            \ 'path_html':'/srv/http/wiki/',
            \ 'template_path':'/srv/http/wiki/',
            \   'template_default':'main_template',
            \ 'template_ext':'.tpl'},
            \ {'path':'~/Dropbox/xdlinux/wiki',
            \ 'path_html':'/srv/http/wiki/xdlinux/',
            \ 'template_path':'/srv/http/wiki/xdlinux/',
            \   'template_default':'main_template',
            \ 'template_ext':'.tpl'}]

let g:vimwiki_folding = 1
let g:vimwiki_CJK_length = 1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
map <leader>tt <Plug>VimwikiToggleListItem
let g:vimwiki_camel_case = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
