
if &t_Co != 256 && ! has("gui_running")
"  echomsg ""
"  echomsg "err: please use GUI or a 256-color terminal (so that t_Co=256 could be set)"
"  echomsg ""
   colorscheme default
   finish
endif

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "textmate256"
hi Normal guifg=#F8F8F8 guibg=#090B18 ctermfg=254 ctermbg=233 cterm=none
hi Cursor guifg=Black guibg=Yellow ctermfg=16 ctermbg=226 cterm=none

hi LineNr guifg=#333333 ctermfg=238 ctermbg=233 cterm=none
hi VertSplit guibg=#c2bfa5 guifg=grey40 gui=none ctermfg=241 ctermbg=187 cterm=none
hi Folded guibg=black guifg=grey50 ctermfg=241 ctermbg=232 cterm=none
hi FoldColumn guibg=black guifg=grey20 ctermfg=236 ctermbg=16 cterm=none
hi IncSearch guibg=black guifg=yellow ctermfg=226 ctermbg=16 cterm=none
hi ModeMsg guifg=goldenrod ctermfg=172 ctermbg=233 cterm=none
hi MoreMsg guifg=SeaGreen ctermfg=72 ctermbg=233 cterm=none
hi NonText guifg=RoyalBlue guibg=#151825 ctermfg=232 ctermbg=232 cterm=none
hi Question guifg=springgreen ctermfg=48 ctermbg=233 cterm=none
hi Search guibg=#0099ff guifg=White ctermfg=231 ctermbg=33 cterm=none
hi Visual gui=none guifg=khaki guibg=olivedrab ctermfg=228 ctermbg=64 cterm=none

hi SpecialKey guifg=#cbfe29 ctermfg=154 ctermbg=233 cterm=none
hi Title guifg=#ff9900 gui=bold ctermfg=208 ctermbg=233 cterm=bold
hi Statement guifg=#ff6600 ctermfg=202 ctermbg=233 cterm=none
hi htmlStatement guifg=#60a3f6
hi String guifg=#61ce38 ctermfg=113 ctermbg=233 cterm=none
"aaaaa
hi Comment guifg=grey55 ctermfg=246 ctermbg=233 cterm=none
hi CommentDoc guifg=grey50 ctermfg=244 ctermbg=233 cterm=none
hi Conditional guifg=#ffee14 ctermfg=226 ctermbg=233 cterm=none
hi Constant guifg=#cbfe29 ctermfg=154 ctermbg=233 cterm=none
hi Special guifg=#86A7D0 ctermfg=110 ctermbg=233 cterm=none
hi Identifier guifg=#ff9900 gui=bold ctermfg=208 ctermbg=233 cterm=bold
hi Include guifg=red ctermfg=196 ctermbg=233 cterm=none
hi PreProc guifg=grey ctermfg=250 ctermbg=233 cterm=none
hi Operator gui=bold guifg=#ff9900 ctermfg=208 ctermbg=233 cterm=bold
hi Define guifg=#ffde00 gui=bold ctermfg=220 ctermbg=233 cterm=bold
hi Type guifg=#60a3f6 ctermfg=75 ctermbg=233 cterm=none
hi Function guifg=#ffde00 gui=NONE ctermfg=220 ctermbg=233 cterm=none
hi Structure gui=bold guifg=#ff6600 ctermfg=202 ctermbg=233 cterm=bold
hi SpellErrors guifg=White guibg=Red ctermfg=231 ctermbg=196 cterm=none
highlight Pmenu guibg=#444444 ctermbg=238 cterm=none
hi Ignore guifg=grey40 ctermfg=241 ctermbg=233 cterm=none
hi StatusLineNC guibg=#c2bfa5 guifg=grey40 gui=none ctermfg=241 ctermbg=187 cterm=none
hi StatusLine guibg=#c2bfa5 guifg=black gui=none ctermfg=16 ctermbg=187 cterm=none
hi Todo guifg=orangered guibg=yellow2 ctermfg=202 ctermbg=226 cterm=none
hi WarningMsg guifg=salmon ctermfg=210 ctermbg=233 cterm=none
hi ErrorMsg guifg=White guibg=Red ctermfg=231 ctermbg=196 cterm=none
hi Error guifg=White guibg=Red ctermfg=231 ctermbg=196 cterm=none

