" Takes a line of TOML and returns the map key and value where map[key]==value}
function! TableName( content )

  let pattern = '^[ \t ]*\[\+\(\zs\(.*\.\)\+\ze\(.\+\)\)\].*$'
  let name = matchstr(a:content, pattern)
  return name[0:strlen(name)-2])
endfunction

function! IsChild( p, c )

  let p = escape(a:p, '.')
  let c = escape(a:c, '.')

  if c ~= p
    return 1
  endif
  return 0
endfunction
