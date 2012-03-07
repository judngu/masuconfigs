au BufNewFile,BufRead *.groovy  setf groovy
au BufNewFile,BufRead *.gsp     setf gsp
au BufNewFile,BufRead *.ftl     setf ftl
au BufNewFile,BufRead *.jst     setf html
au BufNewFile,BufRead *.as      setf actionscript
au! BufRead,BufNewFile *.haml   setfiletype haml
au BufNewFile,BufRead *.handlebars      setf javascript
au BufNewFile,BufRead *.coffee     setf javascript

" markdown filetype file

if exists("did\_load\_filetypes")
 finish
endif
augroup markdown
 au! BufRead,BufNewFile *.mkd   setfiletype mkd
 au! BufRead,BufNewFile *.md   setfiletype mkd
augroup END

