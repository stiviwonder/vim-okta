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


function! OktaIndent()
    let line = getline(v:lnum)
    let previousNum = prevnonblank(v:lnum - 1)
    let previous = getline(previousNum)

    if previous =~ "{" && previous !~ "}" && line !~ "}" && line !~ ":$"
	return indent(previousNum) + &softtabstop
    endif

    " If the previous line is blank, keep the same indentation
    if previous =~ '^\s*$'
        return -1
    endif

    if previous =~ "}" && previous !~ "{" && line !~ "{" && line !~ ":$"
	" return indent(previousNum) - &softtabstop
	return indent(previousNum)
    endif

endfunction

