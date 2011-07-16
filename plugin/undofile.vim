" Vim plugin -- persistent undo: set 'undofile' for certain files only
" File:         undofile.vim
" Created:      2010 Aug 14
" Last Change:  2010 Aug 14
" Rev Days:     0
" Vim Version:	7.3f BETA
" Version:	0.2
" Author:	Andy Wokula <anwoku@yahoo.de>
" License:	Vim License, see :h license

"		PLEASE REPORT BUGS

" Description:
"   If you want 'undofile' only for certain files, you will notice that
"   'undofile' cannot be set in a modeline, or once the buffer is loaded.
"   Bram suggests to use a BufReadPre autocmd which sets 'undofile' before
"   the buffer is loaded.  This script does the steps for you.

" Installation:
"   :source this file when needed, or drop it in your plugin folder

" Usage:
"
" :SetUndoFile[!]
"
"   execute :setlocal undofile, install a BufReadPre autocmd for the current
"   file name and also maintain a plugin file "plugin/undofile_autocmds.vim"
"   that enables all such autocmds at next startup of Vim.
"
"   This means you can execute this command once for the current file and
"   then never ever again -- FIRE AND FORGET ;)
"
"   The plugin file (if not found in the runtimepath) is stored in the first
"   directory of the runtimepath (which must contain a "plugin" folder).
"   Older Vims will ignore the plugin.
"
"   With [!], ignore if 'undofile' is already set.

"
" :UnsetUndoFile
"
"   opposite of :SetUndoFile.  Does :setlocal noundofile, removes the
"   autcommand and the autcommand entry from "plugin/undofile_autocmds.vim";
"   finally it executes :DelUndoFile.
"
"   Command is not named :SetNoUndoFile, because this comes too early in the
"   alphabet.

"
" :DelUndoFile
"
"   delete the undofile for the current buffer.  Fails silently.

" Customization:
"   nothing yet

" Dev Hints:
" - with BufReadPre, local options options can be set
" - exists("#autocmd") vs. "au!"
" - use :try instead of s:plugin_read_ok?

" TODO
" - testing!
" + do not silently overwrite a foreign plugin/undofile_autocmds.vim file
"   ! don't overwrite when it looks odd

" Prologue: {{{
if exists("loaded_undofile")
    finish
endif
let loaded_undofile = 1

if v:version < 703
    echomsg "undofile: you need at least Vim 7.3"
    finish
elseif !has("persistent_undo")
    echomsg "undofile: persistent_undo feature required"
    finish
endif

let s:cpo_save = &cpo
set cpo&vim
" }}}

com! -bar -bang  SetUndoFile	call s:SetUndoFile(<bang>0)
com! -bar	 UnsetUndoFile	call s:UnsetUndoFile()
com! -bar	 DelUndoFile	call s:DelUndoFile()


" :SetUndoFile
func! s:SetUndoFile(bang) "{{{
    if &undofile && !a:bang
	echomsg "SetUndoFile: 'undofile' is already turned on"
	return
    elseif bufname("") == ""
	echoerr "SetUndoFile: buffer must have a name"
	return
    endif

    " set the option for the next :write
    setlocal undofile

    call s:InstallAutocmd(s:GetAuPat(bufname("")))
endfunc "}}}

func! s:InstallAutocmd(aupat) "{{{
    " the autocmd
    let aucmd = 'au BufReadPre '. a:aupat. ' setlocal undofile'

    " install the autocmd for this session:

    if !exists(printf("#%s#%s#%s", s:augroup, "BufReadPre", a:aupat))
	exec "augroup" s:augroup
	exec aucmd
	augroup End
    endif

    " install the autocmd in plugin file:

    let lines = s:ReadPluginFile()
    if index(lines, aucmd) < 0
	let inspos = match(lines, 'augroup End')
	if inspos >= 0
	    call insert(lines, aucmd, inspos)
	    call s:WritePluginFile(lines)
	else
	    echoerr 'SetUndoFile: bad '. s:plugin_file
	endif
    endif

endfunc "}}}

func! s:ReadPluginFile() "{{{
    let plugin_file = s:GetPluginFile()
    let s:plugin_read_ok = 0
    try
	let lines = readfile(plugin_file)
	let s:plugin_read_ok = 1
    catch /:E484:/
	" can't open file; assume file not found, prepare a new file
	" (set s:plugin_read_ok instead of raising an error)
	let lines = s:NewPluginLines()
    endtry
    return lines
endfunc "}}}

func! s:WritePluginFile(lines) "{{{
    let plugin_file = s:GetPluginFile()
    try
	call writefile(a:lines, plugin_file)
	if !s:plugin_read_ok
	    echomsg 'SetUndoFile: wrote a new '. plugin_file
	endif
    catch
	echohl ErrorMsg
	echomsg matchstr(v:exception, ':\zs.*')
	echohl None
    endtry
endfunc "}}}

" turn a file name into an autocmd pattern
func! s:GetAuPat(fname) "{{{
    let aupat = tr(fnamemodify(a:fname, ":p"), '\', '/')
    return aupat
endfunc "}}}

" determine or set a location for the plugin file
func! s:GetPluginFile() "{{{
    if exists("s:plugin_file")
	return s:plugin_file
    endif
    let fname_in_rtp = 'plugin/undofile_autocmds.vim'
    let s:plugin_file = substitute(globpath(&rtp, fname_in_rtp), '\n.*', '', '')
    if s:plugin_file == ""
	let s:plugin_file = s:RtpFirst(). fname_in_rtp
    endif
    return s:plugin_file
endfunc "}}}

" get a plugin template
func! s:NewPluginLines() "{{{
    return [
	\'" This file is automatically read and written',
	\'if !has("persistent_undo")|finish|endif',
	\'augroup '. s:augroup,
	\'au!',
	\'augroup End',
	\]
endfunc "}}}

" choose a runtimepath entry
func! s:RtpFirst() "{{{
    return matchstr(&rtp, '^[^,]*'). '/'
endfunc "}}}

" :UnsetUndoFile
func! s:UnsetUndoFile() "{{{
    setlocal noundofile

    call s:UninstallAutocmd(s:GetAuPat(bufname("")))

    call s:DelUndoFile()
endfunc "}}}

func! s:UninstallAutocmd(aupat) "{{{
    let aucmd = 'au BufReadPre '. a:aupat. ' setlocal undofile'
    let del_aucmd = 'au! '.s:augroup.' BufReadPre '. a:aupat

    " uninstall for this session:
    exec del_aucmd

    " uninstall from plugin file:

    let lines = s:ReadPluginFile()
    if s:plugin_read_ok
	let idx = index(lines, aucmd)
	if idx >= 2
	    call remove(lines, idx)
	    call s:WritePluginFile(lines)
	    " ? postpone the change if the file can't be written now?
	endif
    endif

endfunc "}}}

" :DelUndoFile
func! s:DelUndoFile() "{{{
    let undo_file = undofile(expand("%"))
    call delete(undo_file)

    " if glob(undo_file) == ""
    "     echohl WarningMsg
    "     echo 'Undofile "'. fnamemodify(undo_file, ":."). '" deleted'
    "     echohl None
    " endif
endfunc "}}}


" Init: {{{
let s:augroup = "UndoFile"

" if the plugin file was not successfully read first, give a message when
" writing it; also don't try to uninstall from a bad plugin file:
let s:plugin_read_ok = 0

" }}}

" Epilogue: {{{1
let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set fdm=marker ts=8:
