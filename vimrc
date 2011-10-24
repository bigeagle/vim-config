set iskeyword+=_,$,@,%,#,-
set showcmd

if has("autocmd")
  autocmd BufRead *.txt set tw=78
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

"配色
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
  colorscheme textmate256
  if has("gui_running")
    "colorscheme textmate
    set guioptions-=T "隐藏工具栏
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set gfn=monaco\ 9
    set gfw=黑体-简
    set langmenu=en_US
    set linespace=4
    "set columns=195
    "set lines=45
  endif " has
endif " exists(...)

"光标在窗口上下边界时距离边界7行即开始滚屏
set so=7

"显示行号
set number

"语法高亮度显示
syntax on

call pathogen#runtime_append_all_bundles()

"检测文件的类型 开启codesnip
filetype on
filetype plugin on
filetype indent on
set completeopt=longest,menu " preview
set runtimepath+=~/.vim
au BufNewFile,BufRead *.lng  setf lingo
au BufNewFile,BufRead *.asm set ft=masm
au BufRead,BufNewFile *.txt setlocal ft=txt
"鼠标支持
if has('mouse')
  set mouse=a
  set selection=exclusive
  set selectmode=mouse,key
endif

" 继承前一行的缩进方式，特别适用于多行注释
set autoindent

" 为C程序提供自动缩进
set smartindent

au FileType c,cpp,h,java,js,nginx setlocal cindent

" 使用C样式的缩进
function! GnuIndent()
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=4
  setlocal tabstop=4
endfunction

au FileType c,cpp,h setlocal cinoptions=:0,g0,(0,w1 shiftwidth=4 tabstop=4 softtabstop=4 cc=80
au FileType diff  setlocal shiftwidth=4 tabstop=4
au FileType html,js,css  setlocal autoindent sw=2 ts=2 sts=2 expandtab
au FileType changelog setlocal textwidth=76

set shiftwidth=4
set tabstop=4
set softtabstop=4

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
set ambiwidth=double
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
set statusline=%F%m%r%h%w\ [ASCII=\%03.3b,0x\%02.2B][POS=%04l,%03v][%p%%][LEN=%L]%=[%{GitBranch()}]
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
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
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
set foldenable
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
set foldlevel=100

"程序每次产生一个文件名.
set grepprg=grep\ -nH\ $*
"

set fillchars=vert:\ ,stl:\ ,stlnc:\

" 在搜索的时候忽略大小写
set smartcase
set ignorecase
"
" 不要高亮被搜索的句子（phrases）
set nohlsearch
"
" " 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch

" 插入模式下使用Alt-hjkl移动光标
"if !has("gui_running")
"    imap h <left>
"    imap j <down>
"    imap k <up>
"    imap l <right>
"else
"    inoremap <A-h> <left>
"    inoremap <A-j> <down>
"    inoremap <A-k> <up>
"    inoremap <A-l> <right>
"endif

"LaTex Suite"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SyncTexForward()
  let execstr = "silent !okular --unique %:p:r.pdf\#src:".line(".")."%:p &"
  exec execstr
endfunction

let g:tex_flavor= "latex"
""自动载入latex-suite菜单
let g:tex_flavor="tex"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""Echo Func 设置"""""""""""""""""""""""""""""""""""""""""
let g:EchoFuncLangsUsed = ["c","cpp"]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"智能补全ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
if &filetype=='c'||&filetype=='cpp'
	map <C-F12> :!(ctags -R --c++-kinds=+p --fields=+ialS --extra=+q .;find ./ -name "*.c" -or -name "*.h" -or -name "*.cpp" > cscope.files;cscope -bkq)<cr>:cs a cscope.out<cr>
endif

let OmniCpp_DefaultNamespaces = ["std","_GLIBCXX_STD"]
let OmniCpp_GlobalScopeSearch = 1  " 0 or 1
let OmniCpp_NamespaceSearch = 1   " 0 ,  1 or 2
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1


"-----------------------------------------------------------------
" plugin - NeoComplCache.vim    自动补全插件
"-----------------------------------------------------------------
"let g:neocomplcache_enable_at_startup = 1
"let g:NeoComplCache_SmartCase = 1
"let g:NeoComplCache_TagsAutoUpdate = 1
"let g:NeoComplCache_EnableInfo = 1
"let g:NeoComplCache_EnableCamelCaseCompletion = 1
"let g:NeoComplCache_MinSyntaxLength = 3
"let g:NeoComplCache_EnableSkipCompletion = 1
"let g:NeoComplCache_SkipInputTime = '0.5'
"let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
"let g:neocomplcache_disable_auto_complete=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pydoc_cmd = "/usr/bin/pydoc2"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting

if has("cscope")
  set csprg=/usr/bin/cscope              "指定用来执行 cscope 的命令
  set csto=1                             "先搜索tags标签文件，再搜索cscope数据库
  set cst                                "使用|:cstag|(:cs find g)，而不是缺省的:tag
  set nocsverb                           "不显示添加数据库是否成功
  " add any database in current directory
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType java set omnifunc=javacomplete#Complete

" mapping
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>      pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
"inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"

" CTags的设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tags+=~/.vim/tags/systags
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/glib
"set tags+=/home/bigeagle/.vim/tags/qt4


""""""""""""
" taglist
" """"""""""""
"
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Show_One_File = 0    " 只显示当前文件
let Tlist_Enable_Fold_Column = 0
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Display_Prototype = 0
let Tlist_Use_Right_Window = 1
let tlist_php_settings = 'php;c:classes;i:interfaces;d:const;f:func'
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
let tlist_nc_settings = "nesc;f:function;d:definition;a:task;c:command;e:event"
let tlist_vimwiki_settings = 'wiki;h:Headers'
" 按照名称排序
let Tlist_Sort_Type = "name"
" 压缩方式
let Tlist_Compart_Format = 1
" 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_Exist_OnlyWindow = 1
let Tlist_WinWidth =25
let Tlist_Inc_Winwidth=0

"""""""""""""""""""""""""""""
"miniBufferExplor
"""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

""""""""""""""""""""""""""""""
" NERDTree插件的快捷键
""""""""""""""""""""""""""""""
nmap nt :NERDTree<cr>
let NERDTreeWinSize=25

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
map <F5> :call CompileRun()<CR>

""定义CompileRun函数，用来调用进行编译和运行
func CompileRun()
  exec "w"
  "C程序
  if &filetype == 'c'
	let filename = expand("%<")
    exec "!gcc -Wall -g % -o %<"
    exec "ConqueTermVSplit ./".filename
	"exec \"! ./%<"
    "C++
  elseif &filetype == 'cpp'
	let filename = expand("%<")
    exec "!g++ -Wall -g % -o %<"
    exec "ConqueTermVSplit ./".filename
    "JAVA
  elseif &filetype == 'java'
	let filename = expand("%<")
    exec "!javac %"
    exec "!java %<"
  elseif &filetype == 'python'
    "exec /"!python2 %<"
	let filename = expand("%")
    exec "ConqueTermVSplit python2 ".filename
  elseif &filetype == 'vimwiki'
    "exec /"!python2 %<"
    exec "Vimwiki2HTML"
  elseif &filetype == 'nc'
    "exec /"!python2 %<"
    exec "make micaz"
  endif
endfunc
"结束定义CompileRun

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

"自动匹配括号""""""""""""""""""""""""""""""""""""""""""""""""""""
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

au FileType c,cpp,h,java,css,js,nginx inoremap  <buffer>  {<CR>	{<CR>}<Esc>O
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示
if has("autocmd")
  autocmd FileType xml,html,c,cs,h,java,perl,shell,bash,cpp,python,vim,php,ruby,s,S,tex,js set number
  autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
  autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
  autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
  autocmd Filetype html,xml,xsl source ~/.vim/plugin/closetag.vim
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe " normal g`\"" |
        \ endif
endif "has("autocmd")

"ab bsh #!/bin/bash<CR><CR>
"ab ppy #!/usr/bin/python2<CR><CR>
"ab ppl #!/usr/bin/perl<CR><CR><{}>
"ab rru #!/usr/bin/ruby<CR><CR><{}>

au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()

function ScriptHeader()
  if &filetype == 'python'
	let header = "#!/usr/bin/env python2"
	let coding = "# -*- coding:utf8 -*-"
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
  endif
  normal ''
endfunction


"=======================================================
"twitter vim
let twitvim_enable_python = 1
let twitvim_browser_cmd = 'firefox'
let twitvim_old_retweet = 1
"=======================================================
let g:vimwiki_list=[{'path':'/home/bigeagle/documents/Dropbox/vimwiki',
	  \ 'path_html':'/srv/http/wiki/',
	  \ 'template_path':'/srv/http/wiki/',
	  \	'template_default':'main_template',
	  \ 'template_ext':'.tpl'}]

let g:vimwiki_folding = 1
let g:vimwiki_CJK_length = 1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
map <leader>tt <Plug>VimwikiToggleListItem
let g:vimwiki_camel_case = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
"========================================================
"let g:newrw_ftp_cmd = 'lftp'
let g:netrw_altv          = 1
let g:netrw_fastbrowse    = 2
let g:netrw_keepdir       = 1
let g:netrw_liststyle     = 3
let g:netrw_retmap        = 1
let g:netrw_silent        = 1
let g:netrw_special_syntax= 1
let g:netrw_browse_split = 3
let g:netrw_banner = 0
"===========django====================================
"
"==========tagbar.vim===============
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

"==========private info==============
source ~/.vim/private.vim
