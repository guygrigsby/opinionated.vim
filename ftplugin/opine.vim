" Vim File
" Author: Guy J Grigsby <https://grigsby.dev>
" Version: 0.1.0
" Created: Wed May  6 10:01:59 2020
" Title:   opine.vim
" Summary: 

" quick and dirty for testing
au BufRead,BufNewFile *.yaml,*.yml setfiletype gotexttmpl
nnoremap <buffer> <silent> <leader>ff :call opine#gotemplate#Format()<CR>

command! GoTemplateFormat :execute #opine#gotemplate#Format()
