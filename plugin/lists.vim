" vim-lists - Interchangeable management of quickfix and location lists
" Author: Arthur Xavier
" Repository: https://github.com/arthur-xavier/vim-lists.git

function! s:QuickfixIsOpen()
  " " The command below used to work before Vim8...
  " return len(filter(range(1, winnr('$')), 'getbufvar(winbufnr(v:val), "&buftype") == "quickfix"')) > 0

  " Now the only reliable way to detect whether a quickfix window is opened is
  " by using ls.
  silent! exec 'redir @a | ls | redir END'
  return match(@a,'"\[Quickfix List\]"') >= 0
endfunction

" Execute a quickfix list command (preceded by 'c') if it exists (even if not
" visible), else execute a location list command (preceded by 'l').
function! s:QuickfixOrLocationExists(cmd, ...)
  let cmdl = a:0 == 0 ? a:cmd : a:1
  silent! exec(len(getqflist()) > 0 ? 'c'.a:cmd : 'l'.cmdl)
endfunction

" Execute a quickfix list command if it exists and is visible, else execute a
" location list command (preceded by 'l').
function! s:QuickfixOrLocationIsOpen(cmd, ...)
  let cmdl = a:0 < 1 ? a:cmd : a:1
  echo s:QuickfixIsOpen()
  exec(s:QuickfixIsOpen() ? 'c'.a:cmd : 'l'.cmdl)
endfunction

" Execute a quickfix list command if it exists and is visible, or focus the
" quickfix list if it has only one item. If the Quickfix List does not exist
" or is not visible, execute a location list command or focus it.
function! s:QuickfixOrLocationMove(cmd)
  let qflist = getqflist()
  let loclist = getloclist(0)

  if (s:QuickfixIsOpen() && len(qflist) > 0)
    silent! exec(len(qflist) > 1 ? 'c'.a:cmd : 'cc')
  elseif (len(loclist) > 0)
    silent! exec(len(loclist) > 1 ? 'l'.a:cmd : 'll')
  endif
endfunction

command! Lopen   call s:QuickfixOrLocationExists('open')
command! Lo      call s:QuickfixOrLocationExists('open')

command! Lclose  call s:QuickfixOrLocationIsOpen('close')
command! Lc      call s:QuickfixOrLocationIsOpen('close')

command! Lwindow call s:QuickfixOrLocationExists('win')
command! Lw      call s:QuickfixOrLocationExists('win')

command! Llist   call s:QuickfixOrLocationIsOpen('c', 'l')
command! Ll      call s:QuickfixOrLocationIsOpen('c', 'l')

command! Lnext   call s:QuickfixOrLocationMove('next')
command! Ln      call s:QuickfixOrLocationMove('next')

command! Lprev   call s:QuickfixOrLocationMove('prev')
command! Lp      call s:QuickfixOrLocationMove('prev')
