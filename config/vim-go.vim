let g:go_fmt_options = '-tabs=false -tabwidth=4'
let g:go_fmt_autosave = 0
let g:go_bin_path = expand("~/workspace/golang/bin/")
let g:go_disable_autoinstall = 0
let g:go_play_open_browser = 0

au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap K <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gd <Plug>(go-def)
