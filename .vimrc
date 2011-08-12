set ww+=<,>
" making arrow keys wrap across line breaks in normal mode
imap <Left> <C-O><Left>
imap <Right> <C-O><Right>

set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set tabstop=4
set shiftwidth=4
" shorter version of the above is :set noet ci pi sts=0 sw=4 ts=4
" syntax highlighting
syn on
set number

" thanks to http://items.sjbach.com/319/configuring-vim-right
set hidden
"have % match on if/elsif/else/end/opening and closing XML tags and more
runtime macro/matchit.vim
"set wildmenu=list:longest

" semakes /~style searches case sensitive only if there is a capital letter in
" the search expression. *~style searches will continue to be consistently
" case-sensitive
set ignorecase
set smartcase
set scrolloff=3

" highlight search terms...
set hlsearch
set incsearch " ... dynamically as they are typed


"set fdm=syntax
" whenever I use that it auto-folds everything when I open a file


" ok, this is silly, i admit, but it's 
" more a placeholder so that I'll remember I can do this
" in the future.
if has('gui_running')
	set encoding=utf8
	
	colorscheme anotherdark
else
	colorscheme anotherdark
end


"end thanks



set list
set lcs=tab:»_,trail:·
" non-unicode version of the above
" set lcs=tab:>-,trail:*
" store temp files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" current directory is always matching the
" content of the active window
"set autochdir
" remember some stuff after quiting vim:
" marks, registers, searches, buffer list
set viminfo='20,<50,s10,h,%

" lets you keep indenting or outdenting without reselecting
vnoremap < <gv
vnoremap > >gv



function! g:ToggleNuMode()
	if(&rnu == 1)
		set nu
	else
		set rnu
	endif
endfunc

nnoremap <C-L> :call g:ToggleNuMode()<cr>

" Cut/Copy/Paste {{{1

" Cut (two mappings)
imap <silent> <C-x>   <Nop>
imap <silent> <S-Del> <Nop>
vmap <silent> <C-x>   :<C-u>call Cream_cut("v")<CR>
vmap <silent> <S-Del> :<C-u>call Cream_cut("v")<CR>

" Copy (two mappings)
imap <silent> <C-c>      <Nop>
imap <silent> <C-Insert> <Nop>
vmap <silent> <C-c>      :<C-u>call Cream_copy("v")<CR>
vmap <silent> <C-Insert> :<C-u>call Cream_copy("v")<CR>

" Paste
imap <silent> <C-v>      x<BS><C-o>:call Cream_paste("i")<CR>
imap <silent> <S-Insert> x<BS><C-o>:call Cream_paste("i")<CR>
vmap <silent> <C-v>           :<C-u>call Cream_paste("v")<CR>
vmap <silent> <S-Insert>      :<C-u>call Cream_paste("v")<CR>

" Undo
imap <silent> <C-z> <C-b>:call Cream_undo("i")<CR>
vmap <silent> <C-z> :<C-u>call Cream_undo("v")<CR>
" Redo
imap <silent> <C-y> <C-b>:call Cream_redo("i")<CR>
vmap <silent> <C-y> :<C-u>call Cream_redo("v")<CR>

" Save (only when changes)
imap <silent> <C-s> <C-o>:call Cream_update("i")<CR>
vmap <silent> <C-s> :<C-u>call Cream_update("v")<CR>

function! Cream_cut(mode)
" cut selection to universal clipboard ("+)

	if a:mode == "v"
		normal gv
		normal "+x
	endif
endfunction

function! Cream_copy(mode)
" copy selection to universal clipboard ("+)

	if a:mode == "v"
		normal gv
		normal "+y
		normal gv
	endif
endfunction

function! Cream_paste(mode)
" paste selection from universal clipboard ("+)

	if     a:mode == "v"
		normal gv
		normal "+P
		" correct position
		normal l
		" don't re-select, sizes may differ
	elseif a:mode == "i"
		" fix win32 paste from app
		call setreg('+', @+, 'c')
		let myvirtualedit = &virtualedit
		set virtualedit=all
		normal `^"+gP
		let &virtualedit = myvirtualedit
	endif

endfunction

" Undo and Redo {{{1

function! Cream_undo(mode)
	undo
	if a:mode == "v"
		normal gv
	endif
endfunction

function! Cream_redo(mode)
	redo
	if a:mode == "v"
		normal gv
	endif
endfunction

function! Cream_update(mode)
" save only when changes
" * we don't use the :update command because it can't prompt to SaveAs
"   an un-named file

	if &modified == 1
		call Cream_save()
	endif
	if a:mode == "v"
		" reselect
		normal gv
	endif
endfunction

function! Cream_save()
" save no matter what
	" if new file
	if expand("%") == ""
		if has("browse")
			browse confirm write
		else
			confirm write
		endif
	else
		confirm write
	endif
endfunction


