au BufNewFile,BufRead *.groovy  setf groovy
au BufNewFile,BufRead *.gsp     setf gsp
au BufNewFile,BufRead *.ftl     setf ftl
au BufNewFile,BufRead *.jst     setf html

" markdown filetype file

if exists("did\_load\_filetypes")
 finish
endif
augroup markdown
 au! BufRead,BufNewFile *.mkd   setfiletype mkd
augroup END

