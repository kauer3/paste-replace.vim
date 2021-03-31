if exists("g:loaded_paste_replace") || &cp
  finish
endif
let g:loaded_paste_replace = 1 " version number
let s:keepcpo = &cpo
set cpo&vim

" TODO adapt to <SID>
function! SearchAndReplace(reg)
	" if a:reg == "*"
	" 	let l:msg = "Clipboard search and replace... enter search method (f, t, F, T)"
	" else
	" 	let l:msg = "Yank search and replace... enter search method (f, t, F, T)"
	" endif
	" :echon l:msg
	let l:search1 = getchar()
	if l:search1 == "27"
		return
	elseif l:search1 != "102" && l:search1 != "70" && l:search1 != "116" && l:search1 != "84"
		:echon "Invalid search method"
		return
	endif
	let l:character1 = input("Target:")
	if l:character1 == "27"
		return
	endif
	let l:search2 = input("Search method:")
	if l:search2 == "27"
		return
	elseif l:search2 != "102" && l:search2 != "70" && l:search2 != "116" && l:search2 != "84"
		:echon "Invalid search method"
		return
	endif
	let l:character2 = getchar()
	if l:character2 == "27"
		return
	endif

	execute "normal mp" . nr2char(l:search1) . nr2char(l:character1) . "v`p" . nr2char(l:search2) . nr2char(l:character2)
	call feedkeys('"')
	call feedkeys(a:reg)
	call feedkeys("p")
	call feedkeys("\<ESC>")
	call feedkeys("`p")
endfunction

nnoremap <silent> csr :call SearchAndReplace('*')<CR>
nnoremap <silent> ysr :call SearchAndReplace('0')<CR>
nnoremap <silent> dsr :call SearchAndReplace('"')<CR>

function! s:Replace(type, ...)

	let l:keys = b:paste_replace_keys

	if l:keys[1] == 'restore'
		let l:old_reg = getreg('"')
		let l:old_reg_type = getregtype('"')
	endif

	if l:keys[0] == 'replace'
		let l:method = 'p'
		set paste
	else
		let l:method = 'y'
	endif

	if a:type == 'char'
		silent exe "normal! `["
		let l:start_text_obj = getcurpos()
		silent exe "normal! `]"
		let l:end_text_obj = getcurpos()
		if l:start_text_obj[1] == l:end_text_obj[1] && l:start_text_obj[2] - l:end_text_obj[2] == 1
			if l:keys[0] == 'replace'
				silent exe 'normal! `["' . l:keys[2] . 'P\<esc>'
			endif
		else
			silent exe 'normal! `[v`]"' . l:keys[2] . l:method . '\<esc>'
		endif
	elseif a:type == 'line'
		silent exe 'normal! `[V`]"' . l:keys[2] . l:method . '\<esc>'
	elseif a:type == 'block'
		silent exe 'normal! `[\<C-V>`]"' . l:keys[2] . l:method . '\<esc>'
	endif

	if l:keys[1] == 'restore'
		call setreg('"', old_reg, old_reg_type)
	else
		set nopaste
	endif

endfunction

" TODO implement operator-pending motion 'w' special case

" function! Recursive(first, char, operator, count, motion)
" 	if type(a:char) == type(0)
" 		echom 'nr'
" 	else
" 		echom 'char'
" 	endif
" 	return
" endfunction

" TODO
" nnoremap <expr> tr ":call Recursive('1','" . nr2char(getchar()) . "' ,'3' ,'4' ,'5' )<cr>"

" nnoremap <silent> tr :<C-u>let b:paste_replace_keys = ['copy', '"_c<c-r><c-o>0']
" 	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> cr :<C-u>let b:paste_replace_keys = ['replace', 'restore', '*']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> yr :<C-u>let b:paste_replace_keys = ['replace', 'restore', '0']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> dr :<C-u>let b:paste_replace_keys = ['replace', 'restore', '"']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> cy :<C-u>let b:paste_replace_keys = ['copy', 'restore', '*']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

vnoremap <silent> cr "*p
vnoremap <silent> yr "0p
vnoremap <silent> cy "*y

" TODO restore default register on mapping below
nnoremap <silent> cyy V"*y

"Paste vim "0 register
nnoremap yp "0p
nnoremap yP "0P

" TODO fix to work with counts
nnoremap <silent> yR :call feedkeys('yr$')<CR>
nnoremap <silent> yrr :call feedkeys('Vyr$')<CR>
nnoremap <silent> cR :call feedkeys('cr$')<CR>
nnoremap <silent> crr :call feedkeys('Vcr$')<CR>


"Paste from clipboard
vnoremap <silent> cp "*p
nnoremap <silent> cp "*p

""Replace by clipboard data
" nnoremap <silent> cR :set paste<CR>C<C-r>*<ESC>:set nopaste<CR>
" nnoremap <silent> cR :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . 'C<C-r>*<ESC>'<CR>:set nopaste<CR>
" nnoremap <silent> crr :set paste<CR>cc<C-r>*<ESC>:set nopaste<CR>
" nnoremap <silent> crr :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . 'cc'<C-r>*<ESC><CR>:set nopaste<CR>

" nnoremap <silent> <expr> cy :<C-u>execute 'normal! ' . v:count1 . '"*y . nr2char(getchar()) . <CR>'
nnoremap <silent> cY :<C-u>execute 'normal! ' . v:count1 . '"*y$'<CR>
" vnoremap <silent> cy :<C-u>execute 'normal! ' . v:count1 . '"*y'<CR>

"Yank untill the end of the line
nnoremap <silent> Y :<C-u>execute 'normal! ' . v:count1 . 'y$'<CR>

let &cpo= s:keepcpo
unlet s:keepcpo
