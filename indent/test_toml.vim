let s:tc = unittest#testcase#new('Opine TOML')
function! s:tc.SETUP()
  " Set things up before the tests run
endfunction
function! s:tc.test_one()
  call self.assert(1)
endfunction
function! s:tc.TEARDOWN()
  " Run after tests
endfunction
