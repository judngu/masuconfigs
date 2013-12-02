;; (x-focus-frame nil)
;; ; ^^ Tells emacs GUI to open in front of the terminal it was opened from
;; ; rather than behind

;; ;;========================================
;; ;; start the emacsserver that listens to emacsclient
;; (server-start)

(setq inferior-lisp-program "/Applications/ccl/scripts/ccl") ; your Lisp system
;(setq inferior-lisp-program "/usr/local/bin/clisp") ; your Lisp system
(add-to-list 'load-path "~/workspace/reference/slime/")  ; your SLIME repository
(require 'slime)
(slime-setup)
