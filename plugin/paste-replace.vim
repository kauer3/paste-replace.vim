"Add keybindings to function and add function to clipboard replace
"too
"function! YRRedirect()
	"let l:char = nr2char(getchar())
	"if char == 'i'
		"return execute nmap <expr> yri "ci" . nr2char(getchar()) . "<C-r>0<ESC>"
	"elseif char == 'a'
		"return yra
	"endif
"endfunction

"TODO do search backwards <
"Maybe do two signs (>>) to show direction to search and to paste/replace, and
"in that case maybe don't use the r
"nmap <expr> yr YRRedirect()
"nmap <expr> yrp "ci" . nr2char(getchar()) . "<C-r>0<ESC>"
nmap <expr> yri "ci" . nr2char(getchar()) . "<C-r>0<ESC>"
nmap <expr> yra "ca" . nr2char(getchar()) . "<C-r>0<ESC>"
nmap <expr> yr> "f" . nr2char(getchar()) . "C<C-r>0<ESC>"
nmap <expr> yr< "F" . nr2char(getchar()) . "C<C-r>0<ESC>"
nmap <expr> cri "ci" . nr2char(getchar()) . "<C-r>*<ESC>"
nmap <expr> cra "ca" . nr2char(getchar()) . "<C-r>*<ESC>"
nmap <expr> cr> "f" . nr2char(getchar()) . "C<C-r>*<ESC>"
nmap <expr> cr< "F" . nr2char(getchar()) . "C<C-r>*<ESC>"

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

