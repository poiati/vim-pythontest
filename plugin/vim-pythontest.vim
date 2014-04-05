" ============================================================================
" File:        vim-pythontest.vim
" Description: run your python / django tests
" Maintainer:  Paulo Poiati <paulogpoiati at gmail dot com>
" Version:     0.2.0
" ============================================================================
"

function! s:FindEnclosing(token)
  let currentline = line('.')

  while currentline > 1 
    let matchdata = matchlist(getline(currentline), '\v' . a:token . ' ([^\(]+)')
    if !empty(matchdata)
      return matchdata[1]
    endif
    let currentline -= 1
  endwhile
endfunction


function! RunPythonTest(single)
  let runcommand = "!clear && "

  " Check if it's a Django project
  if filereadable('manage.py')
    let runcommand = runcommand . "python manage.py test"
  else
    let runcommand = runcommand . "python -m unittest"
  endif

  if match(expand('%:t'), '^test') >= 0
    let testfilename = substitute(bufname('%'), getcwd() . '/', '', '')
    let g:testargs = substitute(substitute(testfilename, '/', '.', 'g'), '.py', '', '')

    if a:single
      let g:testargs = g:testargs . '.' . s:FindEnclosing('class') . '.' . s:FindEnclosing('def')
    endif
  endif

  exec(runcommand . ' ' . g:testargs)
endfunction


augroup run_pytest
  autocmd!
  autocmd FileType python nnoremap <silent> <buffer> <Leader>r :call RunPythonTest(0)<CR>
  autocmd FileType python nnoremap <silent> <buffer> <Leader>R :call RunPythonTest(1)<CR>
augroup END
