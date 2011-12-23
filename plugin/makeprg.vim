" Vim global plugin for guessing which makeprg to use
" Last Change: 2011 Dec 14
" Maintainer: Richard Quirk <richard.quirk@gmail.com>
" Modifier: Justin Wong <justin.w.xd@gmail.com>
" License: Apache License 2.0 ( http://www.opensource.org/licenses/apache2.0.php )

if exists("loaded_makeprgs")
	finish
endif
let loaded_makeprgs = 1
let s:save_cpo = &cpo
set cpo&vim

let s:make_types = [
			\ { 'glob': ['makefile', 'Makefile', 'GNUmakefile'],'makeprg': 'make' },
			\ { 'glob': '*.c', 'compiler': 'gcc',
				\ 'makeprg' : 'gcc -o %< %', 'cmd': '!./'.expand('%<') },
			\ { 'glob': '*.cpp','compiler': 'g++', 'makeprg' : 'g++ -o %< %', 'cmd': '!./'.expand('%<') },
			\ { 'glob': '*.py', 'cmd': '!python2 %' },
			\ { 'glob': '*.wiki', 'cmd': 'Vimwiki2HTML'},
			\ { 'glob': 'build.xml', 'compiler': 'ant' },
			\ { 'glob': '*.java', 'compiler': 'javac', 'makeprg' : 'javac %' }
			\ ]

if exists("makeprgs_make_types")
	call insert(s:make_types, makeprgs_make_types)
endif

func MakeType()
	let s:setmake = 0
	let s:setcmd = 0
	exec 'w'
	for s:make_type in s:make_types
		let s:glob_list = []
		if type(s:make_type['glob']) != type([])
			let s:glob_list = [ s:make_type['glob'] ]
		else
			let s:glob_list = s:make_type['glob']
		endif
		for s:g in s:glob_list
			let s:fileList = glob(s:g)
			if len(s:fileList) != 0
				"File Found
				if has_key(s:make_type, 'compiler')
					exe ":compiler " . s:make_type['compiler']
					let s:setmake = 1
				endif
				if has_key(s:make_type, 'makeprg')
					let &makeprg=s:make_type['makeprg']
					let s:setmake = 1
				endif
				if has_key(s:make_type, 'cmd')
					let s:cmd = s:make_type['cmd']
					let s:setcmd = 1
				endif
				if (s:setmake != 0)||(s:setcmd !=0)
					break
				endif
			endif
		endfor
		if s:setmake != 0
			break
		endif
	endfor
	if s:setmake != 0
		exec "make"
		"exec "copen"
	endif
	if s:setcmd != 0
		exec s:cmd
	endif
endfunc

map <F5> :call MakeType()<CR>

let &cpo = s:save_cpo
