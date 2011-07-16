"=============================================================================
"  Author:          DanteZhu - http://www.vimer.cn
"  Email:           dantezhu@vip.qq.com
"  FileName:        showcolor.vim
"  Description:     
"  Version:         1.0
"  LastChange:      2010-09-09 18:14:37
"  History:         
"=============================================================================
function! ShowColor(beginColor,endColor,lineSize) 
    if(!has('gui_running'))
        echohl WarningMsg | echo "Must use this function in gui." | echohl None
        return
    endif
python << EOF
import vim
def LinkColor(xColor,beginColor,endColor):
    strColor = '#%06x' % xColor
    matchName = 'scname%06x' % xColor

    strFgColor = ''
    if xColor > (0xFFFFFF-0x000000)/2:
        strFgColor = '#%06x' % 0x000000
    else:
        strFgColor = '#%06x' % 0xFFFFFF

    cmdHighLight = 'hi %s guifg=%s guibg=%s' % (matchName,strFgColor,strColor)
    cmdMatch = 'syn match %s "%s"' % (matchName,strColor)

    vim.command(cmdMatch)
    vim.command(cmdHighLight)

def PyShowColor():
    beginColor = int(vim.eval('a:beginColor'),16)
    endColor = int(vim.eval('a:endColor'),16)
    lineSize = int(vim.eval('a:lineSize'),10)
    curColor = beginColor
    while(True):
        lColor = []
        for i in range(0,lineSize):
            lColor.append('#%06x' % curColor)
            LinkColor(curColor,beginColor,endColor)
            curColor += 1
            if curColor > endColor:
                break
        vim.current.buffer.append(' '.join(lColor))
        vim.current.buffer.append('\n')
        if curColor > endColor:
            break
vim.current.buffer[:]=None
PyShowColor()
EOF
endfunction

function! ShowColorTerm() 
    if(has('gui_running'))
        echohl WarningMsg | echo "Must use this function in term." | echohl None
        return
    endif
python << EOF
beginColor = 0
endColor = 255
import vim
def LinkColor(xColor):
    matchName = 'scname%u' % xColor

    fgColor = 0
    if xColor > (endColor-beginColor)/2:
        fgColor = beginColor
    else:
        fgColor = endColor

    cmdHighLight = 'hi %s ctermfg=%u ctermbg=%u' % (matchName,fgColor,xColor)
    cmdMatch = 'syn match %s "%03u"' % (matchName,xColor)

    vim.command(cmdMatch)
    vim.command(cmdHighLight)

def PyShowColor():
    lineSize = 16
    curColor = beginColor
    while(True):
        lColor = []
        for i in range(0,lineSize):
            lColor.append('%03u' % curColor)
            LinkColor(curColor)
            curColor += 1
            if curColor > endColor:
                break
        vim.current.buffer.append(' '.join(lColor))
        vim.current.buffer.append('\n')
        if curColor > endColor:
            break
vim.current.buffer[:]=None
PyShowColor()
EOF
endfunction
