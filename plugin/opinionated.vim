" opine.vim - Opinionated formatting
" Author:  Guy J Grigsby <guy@grigsby.dev>
" Version:      0.1
" Created:     2020 April 11
" GetLatestVimScripts: 1697 1 :AutoInstall: surround.vim

if exists("g:loaded_opine")
  finish
endif
let g:loaded_opine = 1

function! Sumorzero( o, t )
  let s = o+t
  if s < 0
    return 0
  endif
  return s
endfunction
