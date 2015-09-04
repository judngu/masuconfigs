au BufNewFile,BufRead   *.groovy setf groovy
"au BufNewFile,BufRead  *.gsp    setf gsp
"^^^ groovy server pages
au BufNewFile,BufRead   *.gsp    setf lisp
"^^^ lisp variant in Go
au BufNewFile,BufRead   *.ftl    setf ftl
au BufNewFile,BufRead   *.jst    setf html
au BufNewFile,BufRead   *.as     setf actionscript
au! BufRead,BufNewFile  *.haml   setfiletype haml
au BufNewFile,BufRead   *.js     setf actionscript
au! BufRead,BufNewFile  *.coffee setfiletype javascript
au! BufRead,BufNewFile  *.asd    setfiletype lisp
au! BufRead,BufNewFile  *.scm    setfiletype lisp
au! BufRead,BufNewFile  *.go     setfiletype go

" markdown filetype file

if exists("did\_load\_filetypes")
 finish
endif
augroup markdown
 au! BufRead,BufNewFile *.mkd   setfiletype markdown
 au! BufRead,BufNewFile *.md   setfiletype markdown
augroup END

au! BufRead,BufNewFile *.cdf  setfiletype cdiff
