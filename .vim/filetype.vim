au BufNewFile,BufRead *.groovy  setf groovy
au BufNewFile,BufRead *.gsp     setf gsp
au BufNewFile,BufRead *.ftl     setf ftl
au BufNewFile,BufRead *.jst     setf html
au BufNewFile,BufRead *.as      setf actionscript
au! BufRead,BufNewFile *.haml   setfiletype haml
au! BufRead,BufNewFile *.coffee setfiletype javascript

" markdown filetype file

if exists("did\_load\_filetypes")
 finish
endif
augroup markdown
 au! BufRead,BufNewFile *.mkd   setfiletype markdown
 au! BufRead,BufNewFile *.md   setfiletype markdown
augroup END

