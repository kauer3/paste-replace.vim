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


function! s:ConcatLines()
	silent exe "normal! `["
	let l:start_text_obj = getline('.')
	silent exe "normal! `]"
	let l:end_text_obj = getline('.')
	let l:lines = l:end_text_obj - l:start_text_obj + 1
	if l:lines > 1
		silent exe "normal! `[" . l:lines . "J"
	endif

endfunction


" For now works only with linewise
function! s:IndentLines()
	silent exe "normal! `[k$"
	let l:start_text_obj = getline('.')
	let l:top_surround = l:start_text_obj[col('.')-1] 
	silent exe "normal! `]j^"
	let l:end_text_obj = getline('.')
	let l:bot_surround = l:end_text_obj[col('.')-1] 
	let l:lines = l:end_text_obj - l:start_text_obj + 1

	if ('{[<' =~ l:top_surround && char2nr(l:bot_surround) - char2nr(l:top_surround) == 2) || (l:top_surround == '(' && l:bot_surround == ')') || ('"' =~ l:top_surround && l:top_surround == l:bot_surround)
		silent exe "normal! `[=`]"
		echom "GREAT SUCCESS!!!"
	endif

endfunction


function! s:Replace(type, ...)

	let l:keys = b:paste_replace_keys
	let l:reg_type = getregtype(l:keys[1])
	echom 'The type is: ' . l:reg_type

	if l:keys[0] == 'copy'
		let l:old_reg = getreg('"')
		let l:old_reg_type = getregtype('"')
		let l:method = 'y'
	else
		if l:keys[0] != 'replace' && l:reg_type != l:keys[0]
			if l:keys[0] == 'v' 
				let l:reg_buffer = getreg(l:keys[1])
				let l:reg_data = trim(getreg(l:keys[1]))
			else
				" if l:keys[0] == 'V' 
				" 	set autoindent
				" endif
				let l:reg_data = trim(getreg(l:keys[1]))
				" let l:reg_data = getreg(l:keys[1])
			endif
			call setreg(l:keys[1], l:reg_data, l:keys[0])
		endif

		let l:method = 'p'
		set paste
	endif


	silent exe "normal! `["
	let l:start_text_obj = getcurpos()
	silent exe "normal! `]"
	let l:end_text_obj = getcurpos()

	if a:type == 'char'
		if l:start_text_obj[1] == l:end_text_obj[1] && l:start_text_obj[2] - l:end_text_obj[2] == 1
			if l:keys[0] != 'copy'

				if l:reg_type == 'v'
					if l:keys[0] == 'v' || l:keys[0] == 'replace'
						silent exe 'normal! `["' . l:keys[1] . 'P\<esc>'
						" echom '90'
					elseif l:keys[0] == 'V'
						silent exe 'normal! `[i=="' . l:keys[1] . 'P\<esc>'
						" echom '93'
					endif

				elseif l:reg_type == 'V'
					if l:keys[0] == 'V' || l:keys[0] == 'replace'
						silent exe 'normal! `[i=="' . l:keys[1] . 'P\<esc>'

						" TODO TODO TODO TODO TODO TODO
					 	call s:IndentLines()
						" TODO TODO TODO TODO TODO TODO

						" echom '98'
					elseif l:keys[0] == 'v'
						silent exe 'normal! `["' . l:keys[1] . 'P\<esc>'
						" echom '101'
					 	call s:ConcatLines()
					endif

				elseif l:reg_type =~ ''
					if l:keys[0] == 'block' || l:keys[0] == 'replace'
						silent exe 'normal! `["' . l:keys[1] . 'P\<esc>'
						echom '101'
					elseif l:keys[0] == 'v'
						silent exe 'normal! `["' . l:keys[1] . 'P\<esc>'
						" echom '101'
					 	call s:ConcatLines()
					elseif l:keys[0] == 'V'
						silent exe 'normal! `[i=="' . l:keys[1] . 'P\<esc>'
						echom '93'
					endif

				" TODO TODO TODO TODO TODO TODO
				else
					echom 'Something is wrong'

				endif

			endif

		else
		" Regular yr operator
			silent exe 'normal! `[v`]"' . l:keys[1] . l:method . '\<esc>'
			if l:keys[0] == 'v'
				call s:ConcatLines()
			endif
		endif
	elseif a:type == 'line'
		echo "It's a Line!!"
		silent exe 'normal! `[V`]' . l:keys[1] . '\<esc>'
	elseif a:type == 'block'
		echo "It's a Block!!"
		silent exe 'normal! `[\<C-V>`]' . l:keys[1] . '\<esc>'
	endif


	if l:keys[0] == 'copy'
		call setreg('"', old_reg, old_reg_type)
	else
		if l:keys[0] != 'replace' && l:reg_type != l:keys[0]
			if l:keys[0] == 'v'
				" echo "It's getting here!!"
				call setreg(l:keys[1], l:reg_buffer, l:reg_type)
			else
				" echo "It's getting there!!"
				call setreg(l:keys[1], l:reg_data, l:reg_type)
			endif
		endif
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

nnoremap <silent> cr :<C-u>let b:paste_replace_keys = ['replace', '*']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> yr :<C-u>let b:paste_replace_keys = ['replace', '0']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> yrv :<C-u>let b:paste_replace_keys = ['v', '0']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> yrV :<C-u>let b:paste_replace_keys = ['V', '0']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> yr :<C-u>let b:paste_replace_keys = ['block', '0']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> dr :<C-u>let b:paste_replace_keys = ['replace', '"']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

nnoremap <silent> cy :<C-u>let b:paste_replace_keys = ['copy', '*']
	\ <bar> set operatorfunc=<SID>Replace<CR>g@

vnoremap <silent> cr "*p
vnoremap <silent> yr "0p
vnoremap <silent> cy "*y

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
