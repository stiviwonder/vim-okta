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

" Find backwards the closest open parenthesis/bracket/brace.
function! s:SearchParensPair()
    let line = line('.')
    let col = col('.')
    
    " Skip strings and comments and don't look too far
    let skip = "line('.') < " . (line - s:maxoff) . " ? dummy :" .
                \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? ' .
                \ '"string\\|comment"'

    " Search for parentheses
    call cursor(line, col)
    let parlnum = searchpair('(', '', ')', 'bW', skip)
    let parcol = col('.')

    " Search for brackets
    call cursor(line, col)
    let par2lnum = searchpair('\[', '', '\]', 'bW', skip)
    let par2col = col('.')

    " Search for braces
    call cursor(line, col)
    let par3lnum = searchpair('{', '', '}', 'bW', skip)
    let par3col = col('.')

    " Get the closest match
    if par2lnum > parlnum || (par2lnum == parlnum && par2col > parcol)
        let parlnum = par2lnum
        let parcol = par2col
    endif
    if par3lnum > parlnum || (par3lnum == parlnum && par3col > parcol)
        let parlnum = par3lnum
        let parcol = par3col
    endif 

    " Put the cursor on the match
    if parlnum > 0
        call cursor(parlnum, parcol)
    endif
    return parlnum
endfunction

function! OktaIndent()
    
    " If we can find an open parenthesis/bracket/brace, line up with it.
    call cursor(a:lnum, 1)
    let parlnum = s:SearchParensPair()
    if parlnum > 0
        let parcol = col('.')
        let closing_paren = match(getline(a:lnum), '^\s*[])}]') != -1
        if match(getline(parlnum), '[([{]\s*$', parcol - 1) != -1
            if closing_paren
                return indent(parlnum)
            else
                return indent(parlnum) + &shiftwidth
            endif
        else
            if closing_paren
                return parcol - 1
            else
                return parcol
            endif
        endif
    endif

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

