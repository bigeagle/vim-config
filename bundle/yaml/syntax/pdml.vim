" Vim syntax file
" Language: PDML (Packet Description  Markup Language)
" Maintainer: Justin Wong <wangyz@smartbow.net>
" Latest Revision: 2013-11-14

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword pdmlTodo contained TODO FIXME XXX NOTE

syn region pdmlComment display oneline start='\%(^\|\s\)#' end='$'
                                \ contains=pdmlTodo,@Spell

syn match pdmlNodeProperty '!\%(![^\\^% ]\+\|[^!][^:/ ]*\)'

syn match pdmlAnchor '&.\+'

syn match pdmlAlias '\*.\+'

syn match pdmlDelimiter '[-,:]'
syn match pdmlBlock '[\[\]{}>|]'
syn match pdmlOperator '[?+-]'
" syn match pdmlKey '\w\+\(\s\+\w\+\)*\ze\s*:'
syn keyword pdmlKey header payloads signed endian typeid enableOn fields name length count dtype elength validate valuerange
syn keyword pdmlType int bitstruct array crc16 crc32
syn keyword pdmlConstant big little

syn region pdmlString matchgroup=pdmlStringDelimiter
                                \ start=+"+ skip=+\\"+ end=+"+
                                \ contains=pdmlEscape
" TODO: This string def doesn't allow for strings at the beginning of lines
syn region pdmlString matchgroup=pdmlStringDelimiter
                                \ start=+\s'+ skip=+''+ end=+'+
                                \ contains=pdmlSingleEscape
syn match pdmlEscape contained display +\\[\\"abefnrtv^0_ NLP]+
syn match pdmlEscape contained display '\\x\x\{2}'
syn match pdmlEscape contained display '\\u\x\{4}'
syn match pdmlEscape contained display '\\U\x\{8}'
" TODO: how do we get 0x85, 0x2028, and 0x2029 into this?
syn match pdmlEscape display '\\\%(\r\n\|[\r\n]\)'
syn match pdmlSingleEscape contained +''+

" TODO: sexagecimal and fixed (20:30.15 and 1,230.15)
syn match pdmlNumber display
                                \ '\<[+-]\=\d\+\%(\.\d\+\%([eE][+-]\=\d\+\)\=\)\='
syn match pdmlNumber display '0\o\+'
syn match pdmlNumber display '0x\x\+'
syn match pdmlNumber display '([+-]\=[iI]nf)'
syn match pdmlNumber display '(NaN)'

syn match pdmlConstant '\<[~yn]\>'
syn keyword pdmlConstant true True TRUE false False FALSE
syn keyword pdmlConstant yes Yes on ON no No off OFF
syn keyword pdmlConstant null Null NULL nil Nil NIL

syn match pdmlTimestamp '\d\d\d\d-\%(1[0-2]\|\d\)-\%(3[0-2]\|2\d\|1\d\|\d\)\%( \%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\d\d [+-]\%([01]\d\|2[0-3]\):[0-5]\d\|t\%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\d\d[+-]\%([01]\d\|2[0-3]\):[0-5]\d\|T\%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\dZ\)\='

syn region pdmlDocumentHeader start='---' end='$' contains=pdmlDirective
syn match pdmlDocumentEnd '\.\.\.'

syn match pdmlDirective contained '%[^:]\+:.\+'

hi def link pdmlTodo Todo
hi def link pdmlComment Comment
hi def link pdmlDocumentHeader PreProc
hi def link pdmlDocumentEnd PreProc
hi def link pdmlDirective Keyword
hi def link pdmlNodeProperty Type
hi def link pdmlAnchor Type
hi def link pdmlAlias Type
hi def link pdmlDelimiter Delimiter
hi def link pdmlBlock Operator
hi def link pdmlOperator Operator
hi def link pdmlKey Identifier
hi def link pdmlString String
hi def link pdmlStringDelimiter pdmlString
hi def link pdmlEscape SpecialChar
hi def link pdmlSingleEscape SpecialChar
hi def link pdmlNumber Number
hi def link pdmlConstant Constant
hi def link pdmlTimestamp Number
hi def link pdmlType Type

let b:current_syntax = "pdml"

let &cpo = s:cpo_save
unlet s:cpo_save
