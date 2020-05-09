" Vim indent file
" Language:    TOML
" Author:  Guy J Grigsby <guy@grigsby.dev>
" Last Change: 2020 April 11
"
let s:tc = unittest#testcase#new('Opine Indent')

function! s:tc.setup()
  source ./toml.vim
endfunction

function! s:tc.teardown()
  " Run after tests
endfunction
"tests IsChild
function! s:tc.test_is_child()

  let parent = ['table.thing', 'table.thing.donkey', 'food.table']
  let child = ['table.thing.child', 'table.otherthing.donkey', 'food.table']
  let exp = [1, 0, 0]

  let index = 0
  while index < len(parent)
    let got = IsChild(parent[index], child[index])
    call self.assert_equal(exp[index], got, printf("parent %s : child %s", parent[index], child[index]))
    let index += 1
  endwhile
endfunction

function! s:tc.test_tablename()
  " literally table driven tests
  let toml = ['[table.thing]', '[table.thing.donkey]', '[food.table]']
  " expected outcomes
  let exp = ['table', 'table.thing', 'food']
  let index = 0
  while index < len(toml)
    let got = TableName(toml[index])
    call self.assert_equal(exp[index], got)
    let index += 1
  endwhile
endfunction


" vim: sw=2 ts=2 et
