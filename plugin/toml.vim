" Vim indent file
" Language:    TOML
" Maintainer:  Guy J Grigsby <guy@grigsby.dev>
" Created:     2020 April 11
" Last Change: 2020 April 11
"
if exists("b:opinionated_indent")
  echo "Skipping load of TOML indent because did_indent has been set"
  finish
endif
let b:opinionated_indent = 1

setlocal indentexpr=GetOpinionatedTomlIndent(v:lnum)

" I know this is gross. I'll fix it.
function! GetOpinionatedTomlIndent( line_num )

  let nline = a:line_num
  if nline == 0
    return 0
  endif

  let sw = 2

  while nline > 0
    let ind = indent(nline - 1 )
    let content = getline(nline)

    if content =~ '^[ \t]*\[\[.*\]\].*$'
      return ind + sw
    elseif content =~ '^[ \t]*\[.*\].*$'
      return sumorzero( ind, -sw )
    endif

    let nline = prevnonblank(nline-1)
    let content = getline(nline)

    if content =~ '^[ \t]*\[.*\].*$'
      return ind + sw
    endif

  endwhile

  return ind
endfunction

function! s:sumorzero( o, t )
  let s = o+t
  if s < 0
    return 0
  endif
  return s
endfunction
