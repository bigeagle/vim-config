" Vim filetype plugin file
" Language:	NesC
" Maintainer:	Lau Ming Leong <http://aming.no-ip.com>
" Last Change:	2007 Apr 02

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
" Behaves just like C
runtime! ftplugin/c.vim ftplugin/c_*.vim ftplugin/c/*.vim
map <C-F12> :!(ctags -R . --languages=nesc)<CR>
