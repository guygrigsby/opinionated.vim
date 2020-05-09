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
  if a:line_num == 0
    call echom printf("first line")
    return 0
  endif

  let index = a:line_num
  if !Tablename( getline(index) )
    call echom printf("(%s) not a table using indent", getline(index))
    return indent(index)
  endif

  let sw = exists('*shiftwidth') ? shiftwidth() : shiftwidth()

  while index > 0
    echom "this line table name " . nTablename
    let pline = prevnonblank(index)
    let ind = indent(pline)

    " table or array of tables; check parent
    let ptable = matchstr(getline(pline), '^[ \t]*\[\+.*\]\+.*$')

    if !ptable
      call echom printf("NO line match %s on line %d", ptable, index)
      continue
    endif
    call echom printf("line match %s on line %d", ptable, index)

    let parent = Tablename( ptable )
    if !parent 
      call echom printf("NO table %s on line %d", parent, index)
      continue
    endif
    call echom printf("table %s on line %d", parent, index)

    if IsChild(parent, nTablename)
      call echom printf("is child table %s on line %d", nTablename, index)
      return ind + sw
    endif

    call echom printf("NO child table %s on line %d", nTablename, index)

    if IsChild(nTablename, parent)
      call echom printf("reverse is child table %s on line %d", parent, index)
      return s:sumorzero( ind, -sw )
    endif
    let index = pline
  endwhile

  call echom printf("END returning last ind")
  return ind
endfunction

" Takes a line of TOML and returns the map key and value where map[key]==value}
function! TableName( content )

  let pattern = '^[ \t ]*\[\+\(\zs\(.*\.\)\+\ze\(.\+\)\)\].*$'
  let name = matchstr(a:content, pattern)
  if name == ""
    return ""
  endif
  let e = strlen(name)-2
  return name[0:e]
endfunction
echom "sourced toml.vim"
" if p is a namespace parent of c returns true, else false
function! IsChild( p, c )
  echom printf("comparing parent %s to child %s", a:p, a:c)

  let p_list = split(a:p, "\\.")
  let c_list = split(a:c, "\\.")
  echo printf("p_list %s c_list %s", p_list, c_list)

  if len(p_list) >= len(c_list)
    echom "child is larger or equal"
    return 0
  endif

  " range over both and if the parent is fully contained in the child, yes
  let index = 0
  while index < len(p_list)-2 "skip the last

    let psec = p_list[index]
    let csec = c_list[index]
    echom printf("psec %s csec %s", psec, csec)
    if csec != psec
      return 0
    endif

    let index += 1

  endwhile
  return 1
endfunction
" vim: sw=2 ts=2 et
