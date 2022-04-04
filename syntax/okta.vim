" Vim syntax file
" " Language: okta
" " Maintainer: Asier Esteban
" " Latest Revision: 24 January 2021
"
if exists("b:current_syntax")
  finish
endif

" Keywords
" syn keyword syntaxElementKeyword keyword1 keyword2 nextgroup=syntaxElement2

syn keyword oktaKeywords for loop while 
syn keyword oktaKeywords if elif else
syn keyword oktaKeywords fun type extern let const use
syn keyword oktaKeywords ret break 
syn keyword oktaKeywords pub
syn keyword oktaKeywords macro derive

syn keyword oktaType i8 i16 i32 i64 
syn keyword oktaType u8 u16 u32 u64 
syn keyword oktaType f32 f64 
syn keyword oktaType bool str c_voidptr struct enum

" " Matches
" syn match syntaxElementMatch 'regexp' contains=syntaxElement1
" nextgroup=syntaxElement2 skipwhite
syn match oktaNumber "\v<\d+>"
syn match oktaNumber "\v<\d+\.\d+>"
syn match oktaNumber "\v<\d*\.?\d+([Ee]-?)?\d+>"
syn match oktaNumber "\v<0x\x+([Pp]-?)?\x+>"
syn match oktaNumber "\v<0b[01]+>"
syn match oktaNumber "\v<0o\o+>"
syn match oktaNumber "true"
syn match oktaNumber "false"

syn match oktaChar "'.'"

syn match oktaBuiltinFn "@\i\+"
" NOTE: for future work
" syn match oktaFunction ".\i\(*)"

syn match oktaComment "#.*$" contains=oktaNotes
syn match oktaNotes contained "\<\(TODO\|FIXME\|NOTE\):"

syntax match oktaOperator display "\V\[-+/*=^&?|!><%~]"

syntax match oktaMultilineStringPrefix /c\?\\\\/ contained containedin=oktaMultilineString

"
" Regions
" syn region syntaxElementRegion start='x' end='y'
" Match strings
syntax region oktaString start=/"/ skip=/\\"/ end=/"/ oneline contains=oktaInterpolatedWrapper

syntax region oktaMultilineString matchgroup=oktaMultilineStringDelimiter start="c\?\\\\" end="$" contains=oktaMultilineStringPrefix display

syntax region oktaInterpolatedWrapper start="\v\\\(\s*" end="\v\s*\)" contained containedin=oktaString contains=oktaInterpolatedString
syntax match oktaInterpolatedString "\v\w+(\(\))?" contained containedin=oktaInterpolatedWrapper

" Highlights
let b:current_syntax = "okta"
highlight default link oktaComment Comment
highlight default link oktaNotes Todo
highlight default link oktaKeywords Keyword
highlight default link oktaType Type
highlight default link oktaString String
highlight default link oktaInterpolatedWrapper Delimiter
highlight default link oktaMultilineString String
highlight default link oktaMultilineStringDelimiter Delimiter
highlight default link oktaNumber Number
highlight default link oktaChar Character
highlight default link oktaBuiltinFn Function
highlight default link oktaOperator Operator
