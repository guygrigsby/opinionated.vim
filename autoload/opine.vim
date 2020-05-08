" Vim ft
" Author: Guy J Grigsby <https://grigsby.dev>
" Version: 0.1.0
" Title:   gotemplate.vim
" Summary: A filetype plugin for go templates
" Note: Based on vin-go html template https://github.com/fatih/vim-go/blob/master/indent/gohtmltmpl.vim


" Only define the function once.
if exists("*opine#gotemplate#Format")
  finish
endif

" don't spam the user when Vim is started in Vi compatibility mode
" 
let s:cpo_save = &cpo
set cpo&vim

function! opine#gotemplate#Format() abort

  let file = readfile(expand("%:p")) " read current file
  for line in file
    " {{.var}} or {{ .var }} or {{- .var -}} or  {{ - .var - }} or 
    let pat = '{{\s*(-\?)\s*\(\..*\)\s*(-\?)\s*}}'
    let sub = '{{\1 \2 \3}}'

    let nline = substitute(line, pat, sub) " regex match
  endfor
endfunction

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 ts=2 et
