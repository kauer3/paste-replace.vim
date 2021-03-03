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
	" TODO make set paste and nopaste work to prevent auto indent on paste
	set paste
	execute "normal mp" . nr2char(l:search1) . nr2char(l:character1) . "v`p" . nr2char(l:search2) . nr2char(l:character2)
	call feedkeys("c")
	call feedkeys("\<C-r>")
	call feedkeys(a:reg)
	call feedkeys("\<ESC>")
	call feedkeys("`p")
	set nopaste
endfunction

nnoremap <silent> csr :call SearchAndReplace("*")<CR>
nnoremap ysr :call SearchAndReplace("0")<CR>

nnoremap <silent> <expr> yri ":set paste<CR>ci" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> yra ":set paste<CR>ca" . nr2char(getchar()) . "<C-r>0<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> yr "c" . nr2char(getchar()) . "<C-r>0<ESC>"
nnoremap <silent> <expr> <expr> yr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>0<ESC>"
nnoremap <silent> <expr> <expr> yr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>0<ESC>"
nnoremap <silent> <expr> cri ":set paste<CR>ci" . nr2char(getchar()) . "<C-r>*<ESC>:set nopaste<CR>"
nnoremap <silent> <expr> cra ":set paste<CR>ca" . nr2char(getchar()) . "<C-r>*<ESC>"
nnoremap <silent> <expr> <expr> cr> nr2char(getchar()) . nr2char(getchar()) . "C<C-r>*<ESC>"
nnoremap <silent> <expr> <expr> cr< nr2char(getchar()) . nr2char(getchar()) . "v^c<C-r>*<ESC>"
nnoremap <silent> <expr> crf . nr2char(getchar()) . "C<C-r>*<ESC>"
nnoremap <silent> <expr> cr "c" . nr2char(getchar()) . "<C-r>*<ESC>"

"Paste vim "0 register
nnoremap yp "0p

""Replace by yanked
nnoremap yR C<C-r>0<ESC>
"nnoremap yr0 d0"0P<ESC>
"nnoremap yr^ d^"0P<ESC>
" TODO prevent yrr from adding new line
nnoremap yrr cc<C-r>0<ESC>

"nnoremap yrl cl<C-r>0<ESC>
"nnoremap yrw cw<C-r>0<ESC>
""nnoremap yriw ciw<C-r>0<ESC>
"nnoremap yrW cW<C-r>0<ESC>
"vmap yr c<C-r>0<ESC>

"Paste from clipboard
nnoremap cp "*p

""Replace by clipboard data
nnoremap cR C<C-r>*<ESC>
"nnoremap cr0 d0"*P<ESC>
"nnoremap cr^ d^"*P<ESC>
nnoremap crr cc<C-r>*<ESC>
"nnoremap crl cl<C-r>*<ESC>
"nnoremap crw cw<C-r>*<ESC>
""nnoremap rpiw ciw<C-r>*<ESC>
"nnoremap crW cW<C-r>*<ESC>

" idea below
"nnoremap c>. f.a
"nnoremap d>. f.lD

nnoremap cy "*y
nnoremap <expr> cy '"*y' . nr2char(getchar())
" map <expr> cy "+y

"Yank untill the end of the line
map Y y$
