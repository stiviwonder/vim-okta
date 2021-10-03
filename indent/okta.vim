" indent/okta.vim
" Lenguage: okta
" Author: stiviwonder

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal expandtab
setlocal nolisp
setlocal autoindent
setlocal indentexpr=OktaIndent()
setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except

" Find the block starter that matches the current line
function! s:BlockStarter(lnum, block_start_re)
    let lnum = a:lnum
    let maxindent = 10000       " whatever
    while lnum > 1
        let lnum = prevnonblank(lnum - 1)
        if indent(lnum) < maxindent
            if getline(lnum) =~ a:block_start_re
                return lnum
            else 
                let maxindent = indent(lnum)
                " It's not worth going further if we reached the top level
                if maxindent == 0
                    return -1
                endif
            endif
        endif
    endwhile
    return -1
endfunction

function! OktaIndent()
    let line = getline(v:lnum)
    let previousNum = prevnonblank(v:lnum - 1)
    let previous = getline(previousNum)

    if line =~ "^\s*\{\>"
	let blkst = s:BlockStarter(v:lnum, '^\s*\{\>')
	if blkst > 0
	    return indent(blkst)
	else 
	    return -1
	endif
    endif

    " if previous =~ "{" && previous !~ "}" && line !~ "}" && line !~ ":$"
    "     return indent(previousNum) + &softtabstop
    " endif

    " if previous =~ "}"
    "     return indent(previousNum) - &softtabstop
    " endif

    " If the previous line is blank, keep the same indentation
    if previous =~ '^\s*$'
        return -1
    endif

endfunction

