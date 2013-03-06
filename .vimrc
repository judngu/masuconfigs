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
set autoindent "





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

" automatically copy visual selections to the clipboard
"set go+=a



" formd Markdown shortcuts
" see http://www.drbunsen.org/formd-a-markdown-formatting-tool.html
nmap <leader>fr :%! formd -r<CR>
nmap <leader>fi :%! formd -i<CR>


"set fdm=syntax
" whenever I use that it auto-folds everything when I open a file


" ok, this is silly, i admit, but it's 
" more a placeholder so that I'll remember I can do this
" in the future.
if has('gui_running')
	set encoding=utf8
	set guifont=Menlo\ for\ Powerline:h18
	
	colorscheme anotherdark
	" In MacVim, you can have multiple tabs open. This mapping makes Ctrl-Tab
	" switch between them, like browser tabs. Ctrl-Shift-Tab goes the other way.
	noremap <C-Tab> :tabnext<CR>
	noremap <C-S-Tab> :tabprev<CR>

	" Switch to specific tab numbers with Command-number
	noremap <D-1> :tabn 1<CR>
	noremap <D-2> :tabn 2<CR>
	noremap <D-3> :tabn 3<CR>
	noremap <D-4> :tabn 4<CR>
	noremap <D-5> :tabn 5<CR>
	noremap <D-6> :tabn 6<CR>
	noremap <D-7> :tabn 7<CR>
	noremap <D-8> :tabn 8<CR>
	noremap <D-9> :tabn 9<CR>
	" Command-0 goes to the last tab
	noremap <D-0> :tablast<CR>
else
	colorscheme anotherdark
end

" create a visual marker at 80 columns
set colorcolumn=80
" lighten the background color slightly
hi Normal guifg=White guibg=#303030

" Change the background on the popups
:hi Pmenu ctermbg=darkgray "for vim
:hi Pmenu guibg=darkgray gui=bold  "for gvim
:hi PmenuSel   ctermfg=White   ctermbg=Blue cterm=Bold guifg=White guibg=DarkBlue gui=Bold 


" set column hilight color 
"hi CursorColumn cterm=none ctermbg=black guibg=black
" set line hilight color
"hi CursorLine cterm=none ctermbg=black guibg=#252525
hi cursorline cterm=none ctermbg=black guibg=#252525
hi cursorcolumn cterm=none ctermbg=black guibg=Gray23
set cursorcolumn
set cursorline

let g:Powerline_symbols = 'fancy'

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete


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

" uses the ftags file to let fuzzyfinder 
" bring up filenames in subdirectories.
" depends on having ~/bin/ftags.sh be run in advance.
set tags+=ftags

command FF FufFile
command FT FufTag

" AutoComplPop has a tendency to freeze 
" when you type a . on some things with 
" bazillions of methods (like numbers)
let g:acp_behaviorRubyOmniMethodLength = -1


" lets you keep indenting or outdenting without reselecting
vnoremap < <gv
vnoremap > >gv

execute pathogen#infect()
" useful with gitgutter
highlight clear SignColumn

" use Ctrl+L to toggle the line number counting method
function! g:ToggleNuMode()
	if(&rnu == 1)
		set nu
	else
		set rnu
	endif
endfunc
nnoremap <C-L> :call g:ToggleNuMode()<cr>

" Toggle the Ctags list on the left pannel with F4
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>
map <F5> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude=.rsync .<CR>


function! UseTabs(...)
	set noet ci pi sts=0 sw=4 ts=4
endfunction
:cabbr ut :call UseTabs()

function TabToggle()
	if &expandtab
		set shiftwidth=4
		set tabstop=4
		set softtabstop=0
		set noexpandtab
	else
		" damn rails geeks and their 2 spaces
		set shiftwidth=2
		set softtabstop=2
		set expandtab
	endif
endfunction
:cabbr tt :call TabToggle()


function! Ott(...)
	:%s/# sort_by_pass_wall_family IN:/# sort_by_pass_wall_family IN:\r      input=[/g
	:%s/# sort_by_pass_wall_family OUT:/# sort_by_pass_wall_family OUT:\r]\r      output=/g
	:%s/# sort_by_pass_family IN:/# sort_by_pass_wall_family IN:\r      input=[/g
	:%s/# sort_by_pass_family OUT:/# sort_by_pass_wall_family OUT:\r]\r      output=/g
endfunction
:cabbr ott :call Ott()


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

" Cream functions: 

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

