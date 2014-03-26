call pathogen#infect()
call pathogen#runtime_append_all_bundles()

set iskeyword+=_,$,@,%,#,-
set showcmd

if has("autocmd")
    "autocmd BufRead *.txt set tw=78
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

"配色
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
    colorscheme molokai
    let g:molokai_original = 1
    "colorscheme textmate256
    if has("gui_running")
        "colorscheme textmate
        set guioptions-=T "隐藏工具栏
        set guioptions-=L
        set guioptions-=r
        set guioptions-=m
        set gfn=Sauce\ Code\ Powerline\ 10
        set gfw=STHeiti\ 9
        set langmenu=en_US
        set linespace=0
        "set columns=195
        "set lines=45
    endif " has
endif " exists(...)

"光标在窗口上下边界时距离边界7行即开始滚屏
set so=7

"显示行号
set number

" 空格代替tab
set expandtab
au Filetype make set noexpandtab

"语法高亮度显示
syntax on


"检测文件的类型 开启codesnip
filetype on
filetype plugin on
filetype indent on
set completeopt=longest,menu " preview
set runtimepath+=~/.vim
au BufNewFile,BufRead *.lng  setf lingo
au BufNewFile,BufRead *.asm set ft=masm
au BufRead,BufNewFile *.txt setlocal ft=txt
"au BufNewFile,BufRead *.xml,*.htm,*.html so ~/.vim/ftplugin/XMLFolding.vim
"鼠标支持
if has('mouse')
    set mouse=a
    "set selection=exclusive
    set selectmode=mouse,key
    set nomousehide
endif

" 继承前一行的缩进方式，特别适用于多行注释
set autoindent

set modeline
" 高亮当前行列
set cursorline
set cursorcolumn

au FileType c,cpp,h,java,javascript,html,htmldjango setlocal cindent

" 使用C样式的缩进
function! GnuIndent()
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=4
    setlocal tabstop=4
endfunction

"astyle as c and cpp styler
autocmd FileType c,cpp,h set formatprg=astyle

au FileType c,cpp,h,java,python,javascript,go setlocal cinoptions=:0,g0,(0,w1 shiftwidth=4 tabstop=4 softtabstop=4 cc=80
au FileType diff  setlocal shiftwidth=4 tabstop=4
au FileType html,css,htmldjango,html,xml setlocal autoindent sw=2 ts=2 sts=2 fdm=manual expandtab
au FileType javascript setlocal sw=4 ts=4 sts=4 expandtab
au FileType changelog setlocal textwidth=76

set shiftwidth=4
set tabstop=4
set softtabstop=4

"set list
"set listchars=tab:▸\ ,eol:¬
"set listchars=tab:..,trail:.,extends:#,nbsp:.,eol:¬

" Recognize standard C++ headers
au BufEnter /usr/include/c++/*    setf cpp
au BufEnter /usr/include/g++-3/*  setf cpp

" Setting for files following the GNU coding standard
au BufEnter /usr/*                call GnuIndent()

function! RemoveTrailingSpace()
    if $VIM_HATE_SPACE_ERRORS != '0' &&
                \(&filetype == 'c' || &filetype == 'cpp' || &filetype == 'vim')
        normal m`
        silent! :%s/\s\+$//e
        normal ``
    endif
endfunction
" Remove trailing spaces for C/C++ and Vim files
au BufWritePre *                  call RemoveTrailingSpace()

if &term=="xterm"
    set t_Co=8
    set t_Sb=^[[4%dm
    set t_Sf=^[[3%dm
endif

" ambiwidth 默认值为 single。在其值为 single 时，
" 若 encoding 为 utf-8，gvim 显示全角符号时就会
" 出问题，会当作半角显示。
" update: 这个问题似乎解决了
"set ambiwidth=double
set autoread                " 自动重新加载外部修改内容
set autochdir               " 自动切换当前目录为当前文件所在的目录
"set spell                   " 拼写检查

"在编辑过程中，在右下角显示光标位置的状态行
set ruler
"set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

set nolinebreak             " 在单词中间断行
" 在状态栏显示目前所执行的指令，未完成的指令片段亦会显示出来
set showcmd
set wrap                    " 自动换行显示
"CmdLine settings {{{
set cmdheight=1             " 设定命令行的行数为 1
set laststatus=2            " 显示状态栏 (默认值为 1, 无法显示状态栏)
"set statusline=%F%m%r%h%w\ [ASCII=\%03.3b,0x\%02.2B][POS=%04l,%03v][%p%%][LEN=%L]%=[%{GitBranch()}]
"

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

"显示匹配括号
set showmatch

"默认无备份
set nobackup
set nowritebackup

"在insert模式下能用删除键进行删除
set backspace=indent,eol,start

"去掉有关vi一致性模式，避免以前版本的一些bug和局限
set nocp
" 增强模式中的命令行自动完成操作
set wildmenu

"文字编码加入utf8
" 设定默认解码
set fenc=utf-8
set fencs=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set enc=utf-8
"let &termencoding=&encoding

" 使用英文菜单,工具条及消息提示
set langmenu=none

"自动缩排
set ai

" 不要闪烁
set novisualbell

"设置语法折叠
set foldmethod=syntax
set foldcolumn=0 "设置折叠区域的宽度
set foldlevel=100
" 用空格键来开关折叠
set nofoldenable
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


"程序每次产生一个文件名.
set grepprg=grep\ -nH\ $*
"

set fillchars=vert:\ ,stl:\ ,stlnc:\
"set fillchars+=stl:\ ,stlnc:\

" 在搜索的时候忽略大小写
set smartcase
set ignorecase
"
" 不要高亮被搜索的句子（phrases）
set nohlsearch
"
" " 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch

""vimdiff
set diffopt+=vertical
"" ]c 跳到上一个冲突处, ]c跳到下一个冲突处, dp = :diffput , :Gwrite 保存

"LaTex Suite"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SyncTexForward()
    let execstr = "silent !okular --unique %:p:r.pdf\#src:".line(".")."%:p &"
    exec execstr
endfunction

let g:tex_flavor= "latex"
""自动载入latex-suite菜单
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""Echo Func 设置"""""""""""""""""""""""""""""""""""""""""
let g:EchoFuncLangsUsed = ["c","cpp"]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"智能补全ctags -R --c++-kinds=+p --fields=+iaS --extra=+q

function! MapCtags()
    if &filetype=='c' || &filetype=='cpp'
        exec "!(ctags -R --c++-kinds=+p --fields=+ialS --extra=+q .;find ./ -name \'*.c\' -or -name \"*.h\" -or -name \"*.cpp\" > cscope.files;cscope -bkq)"
        exec "cs a cscope.out"
    elseif &filetype=='java'
        exec "!(find ./ -name \"*.java\" > cscope.files;cscope -bkq)"
        exec "cs a cscope.out"
    elseif &filetype=~"python"
        exec "!pycscope.py -R"
        exec "cs a cscope.out"
    endif

endfunc

map <C-F12> :call MapCtags()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pydoc_cmd = "/usr/bin/pydoc2"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"autocmd FileType python,python.django set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType jsp set omnifunc=javacomplete#Complete

" mapping
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
"inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"

nmap <leader>ss :syntax sync fromstart<CR>

" CTags的设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au FileType c,h,cpp set tags+=~/.vim/tags/systags
au FileType cpp set tags+=~/.vim/tags/cpp
au FileType c,h set tags+=~/.vim/tags/glib
"set tags+=/home/bigeagle/.vim/tags/qt4

"""""""""""""""""""""""""""""
"miniBufferExplor
"""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
""""""""""""""""""""""""""""""
" vim-powerline
""""""""""""""""""""""""""""""
" let g:Powerline_symbols='fancy'
" if !has("gui_running")
let g:airline_powerline_fonts = 1
" endif
let g:airline_theme = "powerlineish"
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_symbols.space = "\ua0"
""""""""""""""""""""""""""""""
" Indent Guide
""""""""""""""""""""""""""""""
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"加上日期 对应F2
:map <F2> :read !date<CR>

" bind :CD to :cd %:h, then change cwd to the dir that includes current file
""Nerd Comment
nnoremap <C-h> :call NERDComment(0,"toggle") <cr>
vnoremap <C-h> :call NERDComment(1,"toggle") <cr>

"设置程序的运行和调试的快捷键F5和Ctrl-F5
"map <F5> :call CompileRun()<CR>

map <C-F5> :call Debug()<CR>
func Debug()
    exec "w"
    "C程序
    if &filetype == 'c'
        let filename = expand("%<")
        exec "!gcc -Wall % -g -o %<"
        exec "ConqueTermVSplit gdb ".filename

        "C++程序
    elseif &filetype == 'cpp'
        let filename = expand("%<")
        exec "!g++ -Wall % -g -o %<"
        exec "ConqueTermVSplit gdb ".filename
        ""Java程序
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!jdb %<"
    elseif &filetype == 'python'
        let filename = expand("%")
        exec "ConqueTermVSplit python2 -m pdb ".filename
    elseif &filetype == 'vimwiki'
        "exec /"!python2 %<"
        exec "VimwikiAll2HTML"
        exec "setf vimwiki"
    endif
endfunc
"结束定义Debug
"
vmap j gj
vmap k gk
nmap j gj
nmap k gk

nmap tl :TlistToggle<cr>
nmap T :tabnew<cr>

"C花括号
au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap  <buffer>  {<CR> {<CR>}<Esc>O
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示
if has("autocmd")
    autocmd FileType xml,html,c,cs,h,java,perl,shell,bash,cpp,python,vim,php,ruby,s,S,tex,js set number
    autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
    autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
    "autocmd FileType vim,c,java,bash,shell,perl,python setlocal textwidth=100
    autocmd Filetype html,xml,xsl,htmldjango,xhtml source ~/.vim/ftplugin/closetag.vim
    autocmd Filetype html,xml,xsl,htmldjango,xhtml source ~/.vim/ftplugin/html_autoclosetag.vim
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe " normal g`\"" |
                \ endif
    "auto remove trailing spaces
    autocmd FileType c,cpp,scala,coffee,go,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e
    autocmd FileType scala set sw=2 ts=2 sts=2 expandtab
endif "has("autocmd")

au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()

function ScriptHeader()
    if &filetype == 'python'
        let header = "#!/usr/bin/env python2"
        let coding = "# -*- coding:utf-8 -*-"
        let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
    elseif &filetype == 'sh'
        let header = "#!/bin/bash"
    endif
    let line = getline(1)
    if line == header
        return
    endif
    normal m'
    call append(0,header)
    if &filetype == 'python'
        call append(1,coding)
        call append(3, cfg)
    endif
    normal ''
endfunction


"=======================================================
"twitter vim
let twitvim_enable_python = 1
let twitvim_browser_cmd = 'google-chrome'
let twitvim_old_retweet = 1

""======== HTML JS =================
let g:js_indent_log = 0

""=== Session ===
let g:session_autosave = 'yes'

""==== ack ===
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

""==== indentLine ====
if has("gui_running")
    let g:indentLine_char = '|'
else
    let g:indentLine_char = '¦'
endif
let g:indentLine_char = '¦'
au Filetype vimwiki let g:indentLine_noConcealCursor = 1

""==== latex ========
let g:tex_conceal=''

""=== instant markdown ==
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0

""
let g:localvimrc_ask = 0

"" go
let g:auto_gofmt=0

source ~/.vim/config/python-mode.vim
source ~/.vim/config/tagbar.vim
source ~/.vim/config/nerdtree.vim
source ~/.vim/config/vimwiki.vim
source ~/.vim/config/cscope.vim
source ~/.vim/config/omnicpp.vim
source ~/.vim/config/syntastic.vim
source ~/.vim/config/languagetool.vim
source ~/.vim/config/jedi.vim
"source ~/.vim/config/ycm.vim
source ~/.vim/config/rainbow_brackets.vim
"==========private info==============
source ~/.vim/private.vim
