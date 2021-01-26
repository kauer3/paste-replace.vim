"add keybindings to function and add function to clipboard replace
"too
"function! YRRedirect()
	"let l:char = nr2char(getchar())
	"if char == 'i'
		"return execute nmap <expr> yri "ci" . nr2char(getchar()) . "<C-r>0<ESC>"
	"elseif char == 'a'
		"return yra
	"endif
"endfunction

function! GetNChar()
	":echo "Clipboard replace: "
	let l:search1 = getchar()
	:echo type(l:search1)

	if type(l:search1) == type(0)
		let l:counter1 = nr2char(l:search1)
		":echo "Clipboard replace: " . l:counter1
		let l:buffer = l:search1
		while type(l:buffer) == type(0)
			let l:buffer = getchar()
			let l:counter1 .= nr2char(l:buffer)
			":echo "Clipboard replace: " . l:counter1
		endwhile
		l:search1 = nr2char(l:buffer)
	else
		let l:counter1 = 1
	endif

	let l:character1 = nr2char(getchar())
	"if l:search1 == "f"
		":echo "Clipboard replace: " . l:counter1
	let l:search2 = getchar()

	if type(l:search2) == type(0)
		let l:counter2 = nr2char(l:search1)
		:echo "Clipboard replace: " . l:counter2
		let l:buffer = l:search2
		while type(l:buffer) == 0
			l:buffer = getchar()
			l:counter2 .= nr2char(l:buffer)
			:echo "Clipboard replace: " . l:counter2
		endwhile
		l:search2 = l:buffer
	else
		let l:counter2 = 1
	endif
	let l:character2 = nr2char(getchar())

	execute "normal! m`" . l:counter1 . l:search1 . l:character1 . "v``" . l:counter2 . l:search2 . l:character2
	return
endfunction

nnoremap cr :call GetNChar()<CR>

"TODO do search backwards <
"Maybe do two signs (>>) to show direction to search and to paste/replace, and
"in that case maybe don't use the r
"nmap <expr> <expr> crf YRRedirect()
nmap <expr> yri "ci" . nr2char(getchar()) . "<C-r>0<ESC>"
nmap <expr> yra "ca" . nr2char(getchar()) . "<C-r>0<ESC>"
nmap <expr> yr> "f" . nr2char(getchar()) . "C<C-r>0<ESC>"
nmap <expr> yr< "F" . nr2char(getchar()) . "C<C-r>0<ESC>"
nmap <expr> cri "ci" . nr2char(getchar()) . "<C-r>*<ESC>"
nmap <expr> cra "ca" . nr2char(getchar()) . "<C-r>*<ESC>"
nmap <expr> cr> "f" . nr2char(getchar()) . "C<C-r>*<ESC>"
nmap <expr> cr< "F" . nr2char(getchar()) . "C<C-r>*<ESC>"
"nmap <expr> <expr> <expr> crf "f" . nr2char(getchar()) . "v" . nr2char(getchar()) . nr2char(getchar()) . "c<C-r>*<ESC>"

"Paste vim "0 register
nmap yp a<C-r>0<ESC>

"TODO yp< and paraghaph
"Replace by yanked
nmap yR C<C-r>0<ESC>
nmap yrr cc<C-r>0<ESC>
nmap yrl cl<C-r>0<ESC>
nmap yrw cw<C-r>0<ESC>
"nmap yriw ciw<C-r>0<ESC>
nmap yrW cW<C-r>0<ESC>
"nmap ypiW ciW<C-r>0<ESC>
"nmap ypi" ci"<C-r>0<ESC>
"nmap ypi' ci'<C-r>0<ESC>
"nmap ypi( ci(<C-r>0<ESC>
"nmap ypi[ ci[<C-r>0<ESC>
"nmap ypi{ ci{<C-r>0<ESC>
"nmap ypi< ci<<C-r>0<ESC>
"nmap ypit cit<C-r>0<ESC>
"nmap ypaw caw<C-r>0<ESC>
"nmap ypaW caW<C-r>0<ESC>
"nmap ypa" ca"<C-r>0<ESC>
"nmap ypa' ca'<C-r>0<ESC>
"nmap ypa( ca(<C-r>0<ESC>
"nmap ypa[ ca[<C-r>0<ESC>
"nmap ypa{ ca{<C-r>0<ESC>
"nmap ypa< ca<<C-r>0<ESC>
"nmap ypat cat<C-r>0<ESC>

"Paste from clipboard
nmap cp a<C-r>*<ESC>

"TODO cr> and <
"Replace by clipboard data
nmap cR C<C-r>*<ESC>
nmap crr cc<C-r>*<ESC>
nmap crl cl<C-r>*<ESC>
nmap crw cw<C-r>*<ESC>
"nmap rpiw ciw<C-r>*<ESC>
nmap crW cW<C-r>*<ESC>
"nmap cpiW ciW<C-r>*<ESC>
"nmap cpi" ci"<C-r>*<ESC>
"nmap cpi' ci'<C-r>*<ESC>
"nmap cpi( ci(<C-r>*<ESC>
"nmap cpi[ ci[<C-r>*<ESC>
"nmap cpi{ ci{<C-r>*<ESC>
"nmap cpi< ci<<C-r>*<ESC>
"nmap cpit cit<C-r>*<ESC>
"nmap cpaw caw<C-r>*<ESC>
"nmap cpaW caW<C-r>*<ESC>
"nmap cpa" ca"<C-r>*<ESC>
"nmap cpa' ca'<C-r>*<ESC>
"nmap cpa( ca(<C-r>*<ESC>
"nmap cpa[ ca[<C-r>*<ESC>
"nmap cpa{ ca{<C-r>*<ESC>
"nmap cpa< ca<<C-r>*<ESC>
"nmap cpat cat<C-r>*<ESC>

"TODO idea below
"nmap c>. f.a
"nmap d>. f.lD

