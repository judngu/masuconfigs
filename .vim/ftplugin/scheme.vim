" Vim filetype plugin
" Language:      Scheme
" Maintainer:    Sergey Khorev <sergey.khorev@gmail.com>
" URL:		 http://sites.google.com/site/khorser/opensource/vim
" Original author:    Dorai Sitaram <ds26@gte.com>
" Original URL:		 http://www.ccs.neu.edu/~dorai/vimplugins/vimplugins.html
" Last Change:   Mar 5, 2012

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Copy-paste from ftplugin/lisp.vim
setl comments=:;
setl define=^\\s*(def\\k*
setl formatoptions-=t
setl iskeyword+=+,-,*,/,%,<,=,>,:,$,?,!,@-@,94
setl lisp

" make comments behaviour like in c.vim
" e.g. insertion of ;;; and ;; on normal "O" or "o" when staying in comment
setl comments^=:;;;,:;;,sr:#\|,mb:\|,ex:\|#
setl formatoptions+=croql

syn match      schemeError     oneline    ![^ \t()\[\]";]*!
syn match      schemeError     oneline    ")"
" Add TempStruc before Struc and Quoted.
" although TempStruc will be overwritten by them when do hightlighting,
" it still can be used to delimit a sexp.
syn region schemeTempStruc start="(" end=")" contained transparent contains=schemeTempStruc

" Quoted and backquoted stuff

syn region schemeQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" Scheme-specific settings
if exists("b:is_mzscheme") || exists("is_mzscheme")
    " improve indenting
    setl iskeyword+=#,%,^
    setl lispwords+=module,parameterize,let-values,let*-values,letrec-values
    setl lispwords+=define-values,opt-lambda,case-lambda,syntax-rules,with-syntax,syntax-case
    setl lispwords+=define-signature,unit,unit/sig,compund-unit/sig,define-values/invoke-unit/sig
endif

if exists("b:is_chicken") || exists("is_chicken")
    syn match schemeChar oneline "#\\return"
    syn match schemeChar oneline "#!eof"

    " multiline comment
    syntax region schemeMultilineComment start=/#|/ end=/|#/ contains=schemeMultilineComment
    syn region schemeSexpComment start="#;(" end=")" contains=schemeComment,schemeTempStruc
    hi def link schemeSexpComment Comment

    syn match schemeOther oneline    "##[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    " suggested by Alex Queiroz
    syn match schemeExtSyntax oneline    "#![-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    syn region schemeString start=+#<#\s*\z(.*\)+ end=+^\z1$+ 

    syn match schemeShebang "^#!/.*csi.*$"
    hi def link schemeShebang Comment

    " improve indenting
    setl iskeyword+=#,%,^
    setl lispwords+=let-optionals,let-optionals*,declare
    setl lispwords+=let-values,let*-values,letrec-values
    setl lispwords+=define-values,opt-lambda,case-lambda,syntax-rules,with-syntax,syntax-case
    setl lispwords+=cond-expand,and-let*,foreign-lambda,foreign-lambda*


    setl include=\^\(\\(use\\\|require-extension\\)\\s\\+
    setl includeexpr=substitute(v:fname,'$','.scm','')
    setl path+=/usr/local/Cellar/chicken/4.8.0.1
    setl suffixesadd=.scm


    " Indent a toplevel sexp.
    fun! Scheme_indent_top_sexp()
      let pos = getpos('.')
      silent! exec "normal! 99[(=%"
      call setpos('.', pos)
    endfun
    nmap <silent> == :call Scheme_indent_top_sexp()<cr>
endif

let b:undo_ftplugin = "setlocal comments< define< formatoptions< iskeyword< lispwords< lisp<"
