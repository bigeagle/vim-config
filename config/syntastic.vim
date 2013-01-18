let g:syntastic_quiet_warnings=1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['ruby', 'php', 'python' ],
                           \ 'passive_filetypes': ['scala'] }

let g:syntastic_python_checker_args = "--ignore=E225,E401,E501,E302"
map <leader>sc :SyntasticCheck<CR>
