" indent/okta.vim
setlocal indentexpr=OktaIndent()

function! OktaIndent()
    let line = getline(v:lnum)
    let previousNum = prevnonblank(v:lnum - 1)
    let previous = getline(previousNum)

    if previous =~ "{" && previous !~ "}" && line !~ "}" && line !~ ":$"
	return indent(previousNum) + &softtabstop
    endif

    ...
endfunction
