;; Utilities

(use-package llama :ensure t :demand t)
;;transient is a prereq of magit
(use-package transient :ensure t :demand t)
;; the best package ever
(use-package magit
  :ensure t
  :after nerd-icons
  :custom
  (magit-format-file-function #'magit-format-file-nerd-icons)) 
;;emmet-mode
(use-package emmet-mode :ensure t :demand t)

;; binds for moving windows
(global-set-key (kbd "C-c b")  'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c n")    'windmove-up)
(global-set-key (kbd "C-c p")  'windmove-down)

;;org-babel settings
(require 'ob-js)
(defun ob-js-insert-session-header-arg (session)
  "Insert ob-js `SESSION' header argument.
- `js-comint'
- `skewer-mode'
- `Indium'
"
  (interactive (list (completing-read "ob-js session: "
                                      '("js-comint" "skewer-mode" "indium"))))
  (org-babel-insert-header-arg
   "session"
   (pcase session
     ("js-comint" "\"*Javascript REPL*\"")
     ("skewer-mode" "\"*skewer-repl*\"")
     ("indium" "\"*JS REPL*\""))))

(define-key org-babel-map (kbd "J") 'ob-js-insert-session-header-arg)

;; Mermaid mode for graphs
(use-package mermaid-mode :ensure t :demand t)

;;vundo
(use-package vundo :ensure t :demand t)

;;verb
(use-package verb :ensure t :demand t)
(use-package org
  :ensure t
  :demand t
  :mode ("\\.org\\'" . org-mode)
  :config (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(provide 'utility-init)
