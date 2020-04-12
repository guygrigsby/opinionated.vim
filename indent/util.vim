" Takes a line of TOML and returns the map key and value where map[key]==value}
function! IsChild( content, nline )

  let pattern = '^[ \t ]*\[\+\(\zs\(.*\.\)\+\ze\(.\+\)\)\].*$'
  let val = matchstr(a:content, pattern)

  let pcontent = getline(nline-1)
  val = escape(val, '.')

  echo val

  let m = matchstr(pcontent, val[0:strlen(val)-2])
  echo m 
  return m
endfunction
