" Vim indent file
" Language:    TOML
" Author:  Guy J Grigsby <guy@grigsby.dev>
" Last Change: 2020 April 11
"
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Only define the function once.
if exists("*GetOpinionatedTomlIndent")
  finish
endif

setlocal autoindent
setlocal indentexpr=GetOpinionatedTomlIndent(v:lnum)

function! s:sumorzero( o, t )
  let s = o+t
  if s < 0
    return 0
  endif
  return s
endfunction


" I know this is gross. I'll fix it.
function! GetOpinionatedTomlIndent( line_num )
  let nline = a:line_num
  if nline == 0
    return 0
  endif
  let sw = exists('*shiftwidth') ? shiftwidth() : shiftwidth()
  let nTablename = TableName( getline(nline) )


  while nline > 0
    let nline = prevnonblank(nline-1)
    let ind = indent(nline)
    let content = getline(nline)

    " table or array of tables; check parent
    if content =~ '^[ \t]*\[\+.*\]\+.*$'
      let parent = TableName( content )
      let peer = Table
      if nTableName =~ parent
        return ind + sw
      elseif nTable +~ peer 
        return nid
      else
        return s:sumorzero( ind, -sw )
      endif

    endif
  endwhile

  return ind
endfunction
" vim:set sts=2 sw=2:
