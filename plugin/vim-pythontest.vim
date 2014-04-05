" ============================================================================
" File:        vim-pythontest.vim
" Description: run your python / django tests
" Maintainer:  Paulo Poiati <paulogpoiati at gmail dot com>
" Version:     0.1.0
" ============================================================================
"

function! s:FindEnclosing(token)
  let l:currentline = line('.')

  while l:currentline > 1 
    let l:match = matchlist(getline(l:currentline), '\v' . a:token . ' ([^\(]+)')
    if !empty(l:match)
      return l:match[1]
    endif
    let l:currentline -= 1
  endwhile
endfunction


function! RunPythonTest(single)
  let l:command = "!clear && "

  " Check if it's a Django project
  if filereadable('manage.py')
    let l:command = l:command . "python manage.py test"
  else
    let l:command = l:command . "python -m unittest"
  endif

  if match(expand('%:t'), '^test') >= 0
    let g:testfilename = substitute(bufname('%'), getcwd() . '/', '', '')
  endif

  let l:command = l:command . " " . substitute(substitute(g:testfilename, '/', '.', 'g'), '.py', '', '')

  if a:single
    let l:command = l:command . '.' . s:FindEnclosing('class') . '.' . s:FindEnclosing('def')
  endif

  exec(l:command)
endfunction


augroup run_pytest
  autocmd!
  autocmd FileType python nnoremap <silent> <buffer> <Leader>r :call RunPythonTest(0)<CR>
  autocmd FileType python nnoremap <silent> <buffer> <Leader>R :call RunPythonTest(1)<CR>
augroup END
