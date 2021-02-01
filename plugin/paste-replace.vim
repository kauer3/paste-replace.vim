function! SearchAndReplace(reg)
	if a:reg == "*"
		let l:msg = "Clipboard search and replace... enter search method (f, t, F, T)"
	else
		let l:msg = "Yank search and replace... enter search method (f, t, F, T)"
	endif
	:echon l:msg 
	let l:search1 = getchar()
	if l:search1 == "27"
		return
	elseif l:search1 != "102" && l:search1 != "70" && l:search1 != "116" && l:search1 != "84"
		:echon "Invalid search method"
		return
	endif
	let l:character1 = getchar()
	if l:character1 == "27"
		return
	endif
	let l:search2 = getchar()
	if l:search2 == "27"
		return
	endif
	let l:character2 = getchar()
	if l:character2 == "27"
		return
	endif

	execute "normal mp" . nr2char(l:search1) . nr2char(l:character1) . "v`p" . nr2char(l:search2) . nr2char(l:character2)
	call feedkeys("c")
	call feedkeys("\<C-r>")
	call feedkeys(a:reg)
	call feedkeys("\<ESC>")
	call feedkeys("`p")
endfunction

nnoremap <silent> csr :call SearchAndReplace("*")<CR>
nnoremap <silent> ysr :call SearchAndReplace("0")<CR>

nmap <expr> yri "ci" . nr2char(getchar()) . "<C-r>0<ESC>"
nmap <expr> yra "ca" . nr2char(getchar()) . "<C-r>0<ESC>"
nmap <expr> <expr> yr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>0<ESC>"
nmap <expr> <expr> yr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>0<ESC>"
nmap <expr> cri "ci" . nr2char(getchar()) . "<C-r>*<ESC>"
nmap <expr> cra "ca" . nr2char(getchar()) . "<C-r>*<ESC>"
nmap <expr> <expr> cr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>*<ESC>"
nmap <expr> <expr> cr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>*<ESC>"

"Paste vim "0 register
nmap yp a<C-r>0<ESC>

"Replace by yanked
nmap yR C<C-r>0<ESC>
nmap yrR d^"0P<ESC>
nmap yrr cc<C-r>0<ESC>
nmap yrl cl<C-r>0<ESC>
nmap yrw cw<C-r>0<ESC>
"nmap yriw ciw<C-r>0<ESC>
nmap yrW cW<C-r>0<ESC>

"Paste from clipboard
nmap cp a<C-r>*<ESC>

"Replace by clipboard data
nmap cR C<C-r>*<ESC>
nmap crR d^"*P<ESC>
nmap crr cc<C-r>*<ESC>
nmap crl cl<C-r>*<ESC>
nmap crw cw<C-r>*<ESC>
"nmap rpiw ciw<C-r>*<ESC>
nmap crW cW<C-r>*<ESC>

"TODO idea below
"nmap c>. f.a
"nmap d>. f.lD

"Yank untill the end of the line
map Y y$
