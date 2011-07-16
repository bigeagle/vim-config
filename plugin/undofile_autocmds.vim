" This file is automatically read and written
if !has("persistent_undo")|finish|endif
augroup UndoFile
au!
au BufReadPre *rc setlocal undofile
au BufReadPre *.tex setlocal undofile
au BufReadPre *.conf setlocal undofile
au BufReadPre *.c setlocal undofile
au BufReadPre *.cpp setlocal undofile
au BufReadPre *.m setlocal undofile
au BufReadPre *PKGBUILD setlocal undofile
au BufReadPre /home/bigeagle/.latex2html-init setlocal undofile
augroup End
