;; Utilities

;;transient is a prereq of magit
(use-package transient :ensure t :demand t)
;; the best package ever
(use-package magit :ensure t :demand t)

;;emmet-mode
(use-package emmet-mode :ensure t :demand t)

;; multiple cursors
;; Ensure multiple-cursors is managed by elpaca
(elpaca '(multiple-cursors :host github :repo "magnars/multiple-cursors.el")
  ;; Configuration after loading the package
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; expand region
(use-package expand-region
  :ensure (:host github :repo "magnars/expand-region.el")
  :bind ("C-=" . er/expand-region))

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

(provide 'utility-init)
