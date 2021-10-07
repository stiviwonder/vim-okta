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


  "   " If the previous line ends with {, indent one tab in
  "   if previous =~ "{" && previous !~ "}" && line !~ "}" && line !~ ":$"
  "       return indent(previousNum) + &softtabstop
  "   endif

  "   if previous =~ "}"
  "       return indent(previousNum) - &softtabstop
  "   endif

  " If the previous line is inside parenthesis, use the indent of the starting
  " line.
  " Trick: use the non-existing "dummy" variable to break out of the loop when
  " going too far back.

    call cursor(previousNum, 1)
    let parlnum = searchpair('(\|{\|\[', '', ')\|}\|\]', 'nbW',
      	  \ "line('.') < " . (previousNum - s:maxoff) . " ? dummy :"
      	  \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
      	  \ . " =~ '\\(Comment\\|Todo\\|String\\)$'")
    if parlnum > 0
        let previousNumstart = parlnum
	return indent(parlnum)
    else
	return indent(previousNum)
        let previousNumstart = previousNum
    endif

    " If the previous line is blank, keep the same indentation
    if previous =~ '^\s*$'
        return -1
    endif

endfunction

