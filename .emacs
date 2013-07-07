(x-focus-frame nil)
; ^^ Tells emacs GUI to open in front of the terminal it was opened from
; rather than behind

;;========================================
;; start the emacsserver that listens to emacsclient
(server-start)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)


(add-to-list 'load-path "~/.emacs.d/lib")
(require 'undo-tree)
