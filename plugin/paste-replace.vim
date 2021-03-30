" TODO Add count to all mappings possible

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

	if l:keys[1] == 'restore_register'
		let l:old_reg = getreg('"')
		let l:old_reg_type = getregtype('"')
	else
		set paste
	endif

	if a:type == 'char'
		silent exe "normal! `["
		let l:start_text_obj = getcurpos()
		silent exe "normal! `]"
		let l:end_text_obj = getcurpos()
		echom l:start_text_obj[1] l:start_text_obj[2] l:end_text_obj[1] l:end_text_obj[2]
		if l:start_text_obj[1] == l:end_text_obj[1] && l:start_text_obj[2] - l:end_text_obj[2] == 1
			silent exe "normal! `[i\<c-r>" . l:keys[0] . "\<esc>"
		else
			silent exe "normal! `[v`]\"_c\<c-r>" . l:keys[0] . "\<esc>"
		endif
	elseif a:type == 'line'
		silent exe "normal! '[V']" . l:keys[0] . "\<esc>"
	elseif a:type == 'block'
		silent exe "normal! `[\<C-V>`]" . l:keys[0] . "\<esc>"
	" else
	" 	set nopaste
	" 	return
	endif

	if l:keys[1] == 'restore_register'
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

" nnoremap <silent> <expr> cr :let g:paste_replace_special = ['"*p', '']
" 	\ <bar> set operatorfunc=Replace<CR>g@

" nnoremap <silent> cr :<C-u>let b:paste_replace_keys = ['"*p', '']
nnoremap <silent> cr :<C-u>let b:paste_replace_keys = ['*', '']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

" nnoremap <silent> yr :<C-u>let b:paste_replace_keys = ['"0p', '']
nnoremap <silent> yr :<C-u>let b:paste_replace_keys = ['0', '']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> dr :<C-u>let b:paste_replace_keys = ['"', '']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> cy :<C-u>let b:paste_replace_keys = ['"*y', 'restore_register']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

vnoremap <silent> cr "*p
vnoremap <silent> yr "0p
vnoremap <silent> cy "*y

" nnoremap <silent> <expr> cr cw<c-r>*<ESC>
" nnoremap <silent> yrw cw<c-r>0<ESC>

" nnoremap <silent> crw :<C-u>execute "normal!" . v:count1 . "cw<C-r>*"<CR>
" nnoremap <silent> crw :<C-u>execute "normal!cr" . v:count1 . "w"<CR>
" nnoremap <silent> <expr> cr ":set paste<CR>c" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"


" nnoremap <silent> <expr> yri ":set paste<CR>ci" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> yra ":set paste<CR>ca" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> yra "va" . nr2char(getchar()) . '"0p'
" nnoremap <silent> <expr> yr ":set paste<CR>c" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> <expr> yr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>0<ESC>"
" nnoremap <silent> <expr> <expr> yr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>0<ESC>"

" nnoremap <silent> <expr> cri "ci" . nr2char(getchar()) . "<C-r>*<ESC>"
" nnoremap <silent> <expr> cra ":set paste<CR>ca" . nr2char(getchar()) . "<C-r>*<ESC>"
" nnoremap <silent> <expr> cr ":set paste<CR>c" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
" nnoremap <silent> cr<ESC> :echo('Replacement canceled')<CR>
" nnoremap <silent> <expr> <expr> cr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>*<ESC>"
" nnoremap <silent> <expr> <expr> cr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>*<ESC>"

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
