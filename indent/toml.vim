" Vim indent file
" Language:    TOML
" Maintainer:  Guy J Grigsby <guy@grigsby.dev>
" Created:     2020 April 11
" Last Change: 2020 April 11
"
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

echo 'LOADED'

setlocal autoindent
setlocal indentexpr=s:GetOpinionatedTomlIndent(v:lnum)

" I know this is gross. I'll fix it.
function! s:GetOpinionatedTomlIndent( line_num )

  let nline = a:line_num
  if nline == 0
    return 0
  endif
  let sw = exists('*shiftwidth') ? shiftwidth() : shiftwidth()

  while nline > 0
    let ind = indent(nline - 1 )
    let content = getline(nline)

    if content =~ '^[ \t]*\[\[.*\]\].*$'
      return ind + sw
    elseif content =~ '^[ \t]*\[.*\].*$'
      return Sumorzero( ind, -sw )
    endif

    let nline = prevnonblank(nline-1)
    let content = getline(nline)

    if content =~ '^[ \t]*\[.*\].*$'
      return ind + sw
    endif

  endwhile

  return ind
endfunction
" vim:set sts=2 sw=2:
