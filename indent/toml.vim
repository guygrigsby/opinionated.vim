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

function! Tablename( content )
  "let pattern = '^[ \t ]*\[\+\(\(.*\.\)\+\(.\+\)\)\].*$'
  "let name = matchstr( content, pattern )
  echom "Content " . content . " Pattern " . pattern
  "echom "table name " . name
  "return name[1:strlen(name)-2]
  let end = strlen(content)-2
  echom "end " . end . " end"
  return content[1:end]
endfunction


" I know this is gross. I'll fix it.
function! GetOpinionatedTomlIndent( line_num )
  let nline = a:line_num
  if nline == 0
    return 0
  endif
  let sw = exists('*shiftwidth') ? shiftwidth() : shiftwidth()
  let nTablename = Tablename( getline(nline) )
  echom "this line table name " . nTablename
  let pline = prevnonblank(nline-1)
  let ind = indent(pline)
  let pcontent = getline(pline)

  " table or array of tables; check parent
  if pcontent =~ '^[ \t]*\[\+.*\]\+.*$'
    if !nTableName
      return ind + sw
    endif
    let parent = Tablename( pcontent )
    if !parent 
      return ind
    endif

    if stridx(nTableName, parent) >= 0
      return ind + sw
    endif

    let prev_names = split(parent, ".")
    let new_names = split(nTableName, ".")
    let deb = "comparing " . parent . " to " . nTableName
    echom deb
    if strlen(prev_names) != strlen(new_names)
      return s:sumorzero( ind, -sw )
    endif

    let i = 0
    while i < strlen(prev_names)-1
      let deb = "comparing " . prev_names[i] . " to " . new_names[i]
      echom deb
      if prev_names[i] != new_names[i]
        return s:sumorzero( ind, -sw )
      endif
      let i += 1
    endwhile
  endif

  echom "returning ind"
  return ind
endfunction
" vim:set sts=2 sw=2:
