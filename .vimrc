" masukomi's current .vimrc
scriptencoding utf-8

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'tomtom/tcomment_vim'
Plugin 'masukomi/rainbow_parentheses.vim'
Plugin 'itspriddle/vim-marked'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'chrisbra/Colorizer'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-surround'

" LANGUAGE PLUGINS
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'Keithbsmiley/swift.vim'
" LANGUAGE ENHANCING PLUGINS
Plugin 'rcyrus/snipmate-snippets-rubymotion'
Plugin 'jelera/vim-javascript-syntax'
"Plugin 'fousa/vim-flog'
"Plugin 'skammer/vim-ruby-complexity'
"Plugin 'malept/vim-flog'
"Plugin 'kchmck/vim-coffee-script'
"Plugin 'tpope/vim-endwise'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'scrooloose/syntastic'
"Plugin 'kien/ctrlp.vim'
"Plugin 'masukomi/vim-slime'
"Plugin 'Floobits/vim-plugin'
"Plugin 'itspriddle/vim-marked'
"Plugin 'oplatek/Conque-Shell'
"Plugin 'nelstrom/vim-markdown-folding'
"Plugin 'goldfeld/criticmarkup-vim'
"Plugin 'sjl/AnsiEsc.vim'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'wlangstroth/vim-racket'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" configurations for vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1
" end vim-airline stuff
"let g:Powerline_symbols = 'fancy'

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
"let g:airline_symbols.space = "\ua0"

filetype plugin indent on    " required
let g:colorizer_auto_filetype='cdiff'

" ruby complexity plugin
"g:rubycomplexity_enable_at_startup

"let $XIKI_DIR="~/xiki-master"
"let $XIKI_DIR="~/workspace/xiki"
"source $XIKI_DIR/misc/vim/xiki.vim

set runtimepath^=~/.vim/bundle/ctrlp.vim
runtime macros/matchit.vim
runtime ftplugin/ruby/ruby-matchit.vim

" Control P (fuzzy file find / open)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

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
set textwidth=80

" Make the selection not include the character under the cursor
" so that you it doesn't keep selecting the newline at the end
" set selection=exclusive

" Disable "EX Mode"
map Q <Nop>

" Allow saving of files as sudo when you forget to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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

augroup RainbowParentheses
    au!
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
augroup END

" formd Markdown shortcuts
" see http://www.drbunsen.org/formd-a-markdown-formatting-tool.html
nmap <leader>fr :%! formd -r<CR>
nmap <leader>fi :%! formd -i<CR>


set foldmethod=syntax
" whenever I use that without foldlevel
" it auto-folds *everything* when I open a file
set foldlevel=1
" tell it to remember the fold levels you last had in each file
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" ok, this is silly, i admit, but it's
" more a placeholder so that I'll remember I can do this
" in the future.
if has('gui_running')
set encoding=utf8
" POWERLINE FONTS FOUND HERE: https://github.com/powerline/fonts/tree/master/Inconsolata-g
"set guifont=Menlo\ for\ Powerline:h22
"set guifont=InputMono\ for\ Powerline:h22
" uses the Menlo-Powerline.otf font
"set guifont=Inconsolata-dz\ for\ Powerline:h22
set guifont=Inconsolata-g\ for\ Powerline:h22



" lighten the background color slightly
hi Normal guifg=White guibg=#303030
" Change the gutter color in Syntastic
hi SignColumn ctermbg=black guibg=#303030

" Change the background on the popups
:hi Pmenu ctermbg=darkgray "for vim
:hi Pmenu guibg=darkgray gui=bold  "for gvim
:hi PmenuSel   ctermfg=White   ctermbg=Blue cterm=Bold guifg=White guibg=DarkBlue gui=Bold

" VISUALIZE TABS AND TRAILING SPACES
set list
set lcs=tab:»_,trail:·
highlight SpecialKey ctermfg=8 guifg=DimGrey
" non-unicode version of the above
" set lcs=tab:>-,trail:*

" CROSSHAIRS

" set line hilight color
hi cursorline cterm=none ctermbg=black guibg=Gray14
" set column hilight color
hi cursorcolumn cterm=none ctermbg=black guibg=Gray14
" now actually turn it on
set cursorcolumn
set cursorline
" END CROSSHAIRS

" CREATE A VISUAL MARKER AT 80 COLUMNS
" if version > 720 " this number doesn't work on all systems... is weird
" honestly I don't know what version this
" came into play but dreamhost has v 7.2
" and it doesn't work on that. ;)
set colorcolumn=80
highlight colorcolumn guibg=Black
" optionally ColorColumn
" endif

" DIFF HIGHLIGHTING
" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


" MACVIM
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




" PLUGINS STUFF

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript call JavaScriptFold()
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"end thanks


" If we're in a scheme file, it's gonna be Chicken Scheme
let g:is_chicken=1
setl complete+=,k~/.vim/chicken_scheme_word_list

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


" AutoComplPop has a tendency to freeze
" when you type a . on some things with
" bazillions of methods (like numbers)
let g:acp_behaviorRubyOmniMethodLength = -1


" lets you keep indenting or outdenting without reselecting
vnoremap < <gv
vnoremap > >gv



" use Ctrl+L to toggle the line number counting method
function! g:ToggleNuMode()
	if(&rnu == 1)
		set nornu
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

function Border()
	set colorcolumn=80
	highlight colorcolumn guibg=Black
endfunction
:cabbr border :call Border()

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

function GoFull()
	set fuoptions=maxvert fu
endfunction
:cabbr gof :call GoFull()

" Text Expansions
iab sterr $stderr.puts("XXX")<ESC>bi


" Removes trailing spaces
" function! TrimWhiteSpace()
"     %s/\s\+$//e
" endfunction
"
" nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

" autocmd FileType ruby,python,java autocmd FileWritePre    * :call TrimWhiteSpace()
" autocmd FileType ruby,python,java autocmd FileAppendPre   * :call TrimWhiteSpace()
" autocmd FileType ruby,python,java autocmd FilterWritePre  * :call TrimWhiteSpace()
" autocmd FileType ruby,python,java autocmd BufWritePre     * :call TrimWhiteSpace()

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


