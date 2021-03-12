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
	cal feedkeys(a:reg)
	call feedkeys("p")
	call feedkeys("\<ESC>")
	call feedkeys("`p")
endfunction

" nnoremap <silent> csr :call SearchAndReplace("*")<CR>
" nnoremap <silent> ysr :call SearchAndReplace("0")<CR>
nnoremap <silent> csr :call SearchAndReplace("*")<CR>
nnoremap <silent> ysr :call SearchAndReplace("0")<CR>

function! Replace(type)
	" let l:search1 = getchar()
	" if l:search1 == "27"
	" 	return
	" elseif l:search1 != "102" && l:search1 != "70" && l:search1 != "116" && l:search1 != "84"
	" 	:echon "Invalid search method"
	" 	return
	" endif
	" let l:character1 = input("Target:")
	" if l:character1 == "27"
	" 	return
	" endif
	" let l:search2 = input("Search method:")
	" if l:search2 == "27"
	" 	return
	" elseif l:search2 != "102" && l:search2 != "70" && l:search2 != "116" && l:search2 != "84"
	" 	:echon "Invalid search method"
	" 	return
	" endif
	" le l:character2 = getchar()
	" if l:character2 == "27"
	" 	return
	" endif



	echom a:type



	" execute "normal" . v:count1 . "c" . nr2char(getchar()) . expand("<C-r>*<ESC>")<cr>



	" call feedkeys('"')
	" cal feedkeys(a:reg)
	" call feedkeys("p")
	" call feedkeys("\<ESC>")
	" call feedkeys("`p")
endfunction


" nnoremap <silent> cp :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . '"*p'<CR>:set nopaste<CR>
" nnoremap <silent> <expr> yri ":set paste<lt>CR>:<C-u>execute 'normal!'" . v:count1 . "ci" . input("input") . "<C-r>0:set nopaste<lt>CR>"'
" nnoremap <expr> <silent> yri ':<C-u>execute "normal!"' . v:count1 . ci . nr2char(getchar()) . '<C-r>0<ESC>'

" nnoremap <silent> <expr> cr ":<C-u>execute 'c' . nr2char(getchar()) . '<C-r>*'"
" nnoremap <silent> <expr> cr ":<C-u>execute'c'" . nr2char(getchar()) . "<C-r>*<ESC><CR>"

nnoremap <silent> cr :set operatorfunc=Replace<CR>g@

" nnoremap <silent> cr :<C-u>execute "normal!" . v:count1 . "cw<C-r>*"<CR>
" nnoremap <silent> <expr> cr ":set paste<CR>c" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"


nnoremap <silent> <expr> yri ":set paste<CR>ci" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> yra ":set paste<CR>ca" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> yra "va" . nr2char(getchar()) . '"0p'
nnoremap <silent> <expr> yr ":set paste<CR>c" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> <expr> <expr> yr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>0<ESC>"
" nnoremap <silent> <expr> <expr> yr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>0<ESC>"
nnoremap <silent> <expr> yrf ":set paste<CR>cf" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> yrF ":set paste<CR>cF" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> yrt ":set paste<CR>ct" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> yrT ":set paste<CR>cT" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
" nnoremap <silent> yr<ESC> :echo('Replacement canceled')<CR>

nnoremap <silent> <expr> cri "ci" . nr2char(getchar()) . "<C-r>*<ESC>"
nnoremap <silent> <expr> cra ":set paste<CR>ca" . nr2char(getchar()) . "<C-r>*<ESC>"
" nnoremap <silent> <expr> cr ":set paste<CR>c" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
" nnoremap <silent> cr<ESC> :echo('Replacement canceled')<CR>
nnoremap <silent> <expr> <expr> cr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>*<ESC>"
nnoremap <silent> <expr> <expr> cr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>*<ESC>"
" nnoremap <silent> <expr> crf ":set paste<CR>cf" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> crF ":set paste<CR>cF" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> crt ":set paste<CR>ct" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> crT ":set paste<CR>cT" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"

"Paste vim "0 register
nnoremap yp "0p
nnoremap yP "0P

""Replace by yanked
" nnoremap yR C<C-r>0<ESC>

" nnoremap yR v$h"0p
" nnoremap yR C"0p
nnoremap <silent> yR :set paste<CR>C<C-r>0<ESC>:set nopaste<CR>

"nnoremap yr0 d0"0P<ESC>
"nnoremap yr^ d^"0P<ESC>


nnoremap yrr V"0p

"nnoremap yrl cl<C-r>0<ESC>
"nnoremap yrw cw<C-r>0<ESC>
""nnoremap yriw ciw<C-r>0<ESC>
"nnoremap yrW cW<C-r>0<ESC>
"vmap yr c<C-r>0<ESC>


"Paste from clipboard
nnoremap <silent> cp :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . '"*p'<CR>:set nopaste<CR>
nnoremap <silent> cP :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . '"*P'<CR>:set nopaste<CR>
" nnoremap <silent> cp :set paste<CR>"*p:set nopaste<CR>
" nnoremap <silent> cP :set paste<CR>"*P:set nopaste<CR>

""Replace by clipboard data
" nnoremap <silent> cR :set paste<CR>C<C-r>*<ESC>:set nopaste<CR>
nnoremap <silent> cR :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . 'C<C-r>*<ESC>'<CR>:set nopaste<CR>
" nnoremap <silent> crr :set paste<CR>cc<C-r>*<ESC>:set nopaste<CR>
nnoremap <silent> crr :set paste<CR>:<C-u>execute 'normal! ' . v:count1 . 'cc<C-r>*<ESC>'<CR>:set nopaste<CR>

" nnoremap cy "*y
" vnoremap cy "*y
nnoremap <silent> <expr> cy :<C-u>execute 'normal! ' . v:count1 . '"*y . nr2char(getchar()) . <CR>'
nnoremap <silent> cY :<C-u>execute 'normal! ' . v:count1 . '"*y$'<CR>
vnoremap <silent> cy :<C-u>execute 'normal! ' . v:count1 . '"*y'<CR>

"Yank untill the end of the line
" " map Y y$
" nnoremap <silent> Y :<C-u>execute 'normal! ' . v:count1 . 'y$'<CR>

" idea below
"nnoremap c>. f.a
"nnoremap d>. f.lD

" nnoremap <silent> <expr> cy '"*y' . nr2char(getchar())
" nnoremap <silent> <expr> cY '"*y$'

