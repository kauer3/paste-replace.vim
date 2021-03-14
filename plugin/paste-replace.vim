" TODO Add count to all mappings possible

if exists("g:loaded_paste_replace")
  finish
endif
let g:loaded_paste_replace = 1

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
	le l:character2 = getchar()
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

" nnoremap <silent> csr :call SearchAndReplace("*")<CR>
" nnoremap <silent> ysr :call SearchAndReplace("0")<CR>
nnoremap <silent> csr :call SearchAndReplace("*")<CR>
nnoremap <silent> ysr :call SearchAndReplace("0")<CR>


function! Replace(type, ...)

	let l:reg = g:paste_replace_data

	if l:reg[1] == 'restore_register'
		let l:old_reg = getreg('"')
		let l:old_reg_type = getregtype('"')
	endif

	set paste

	if a:type == 'char'
		silent exe "normal! `[v`]" . l:reg[0] . "\<esc>"
	elseif a:type == 'line'
		silent exe "normal! '[V']" . l:reg[0] . "\<esc>"
	elseif a:type == 'block'
		silent exe "normal! `[\<C-V>`]" . l:reg[0] . "\<esc>"
	else
		set nopaste
		return
	endif

	set nopaste

	if l:reg[1] == 'restore_register'
		call setreg('"', old_reg, old_reg_type)
	endif

endfunction

" TODO
function! Recursive(first, char, operator, count, motion)
	if type(a:char) == type(0) 
		echom 'nr'
	else
		echom 'char'
	endif
	return
endfunction
" TODO
nnoremap <expr> tr ":call Recursive('1','" . nr2char(getchar()) . "' ,'3' ,'4' ,'5' )<cr>"
" nnoremap <silent> <expr> cr :let g:paste_replace_special = ['"*p', '']
" 	\ <bar> set operatorfunc=Replace<CR>g@


nnoremap <silent> cr :let g:paste_replace_data = ['"*p', '']
	\ <bar> set operatorfunc=Replace<CR>g@

nnoremap <silent> yr :let g:paste_replace_data = ['"0p', '']
	\ <bar> set operatorfunc=Replace<CR>g@

nnoremap <silent> cy :let g:paste_replace_data = ['"*y', 'restore_register']
	\ <bar> set operatorfunc=Replace<CR>g@

vnoremap <silent> cr "*p
vnoremap <silent> yr "0p
vnoremap <silent> cy "*y
" vnoremap <silent> cr :let g:paste_replace_data = "*"
" 	\ <bar> <c-u>call Replace(visualmode())<cr>
" vnoremap <silent> yr :let g:paste_replace_data = "0"
" 	\ <bar> <c-u>call Replace(visualmode())<cr>

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
" nnoremap <silent> <expr> yrf ":set paste<CR>cf" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> yrF ":set paste<CR>cF" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> yrt ":set paste<CR>ct" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> yrT ":set paste<CR>cT" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> yr<ESC> :echo('Replacement canceled')<CR>

" nnoremap <silent> <expr> cri "ci" . nr2char(getchar()) . "<C-r>*<ESC>"
" nnoremap <silent> <expr> cra ":set paste<CR>ca" . nr2char(getchar()) . "<C-r>*<ESC>"
" nnoremap <silent> <expr> cr ":set paste<CR>c" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
" nnoremap <silent> cr<ESC> :echo('Replacement canceled')<CR>
" nnoremap <silent> <expr> <expr> cr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>*<ESC>"
" nnoremap <silent> <expr> <expr> cr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>*<ESC>"
" " nnoremap <silent> <expr> crf ":set paste<CR>cf" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> crF ":set paste<CR>cF" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> crt ":set paste<CR>ct" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> crT ":set paste<CR>cT" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"

"Paste vim "0 register
nnoremap yp "0p
nnoremap yP "0P


nnoremap yR :call feedkeys('yr$')<CR>

" Will be enough when yr is working
" nnoremap <silent> yR yr$

"nnoremap yr0 d0"0P<ESC>
"nnoremap yr^ d^"0P<ESC>


nnoremap yrr V:call feedkeys('yr$')<CR>

"nnoremap yrl cl<C-r>0<ESC>
"nnoremap yrw cw<C-r>0<ESC>
""nnoremap yriw ciw<C-r>0<ESC>
"nnoremap yrW cW<C-r>0<ESC>
"vmap yr c<C-r>0<ESC>


"Paste from clipboard
nnoremap <silent> cp :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . '"*p'<CR>:set nopaste<CR>
nnoremap <silent> cP :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . '"*P'<CR>:set nopaste<CR>
vnoremap <silent> cp "*p
" nnoremap <silent> cp :set paste<CR>"*p:set nopaste<CR>
" nnoremap <silent> cP :set paste<CR>"*P:set nopaste<CR>

""Replace by clipboard data
" nnoremap <silent> cR :set paste<CR>C<C-r>*<ESC>:set nopaste<CR>
nnoremap <silent> cR :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . 'C<C-r>*<ESC>'<CR>:set nopaste<CR>
" nnoremap <silent> crr :set paste<CR>cc<C-r>*<ESC>:set nopaste<CR>
nnoremap <silent> crr :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . 'cc'<C-r>*<ESC><CR>:set nopaste<CR>

" nnoremap <silent> <expr> cy :<C-u>execute 'normal! ' . v:count1 . '"*y . nr2char(getchar()) . <CR>'
nnoremap <silent> cY :<C-u>execute 'normal! ' . v:count1 . '"*y$'<CR>
" vnoremap <silent> cy :<C-u>execute 'normal! ' . v:count1 . '"*y'<CR>

"Yank untill the end of the line
nnoremap <silent> Y :<C-u>execute 'normal! ' . v:count1 . 'y$'<CR>

" idea below
"nnoremap c>. f.a
"nnoremap d>. f.lD

" nnoremap <silent> <expr> cy '"*y' . nr2char(getchar())
" nnoremap <silent> <expr> cY '"*y$'
