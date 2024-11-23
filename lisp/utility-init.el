;; Utilities

;;transient is a prereq of magit
(use-package transient :ensure t :demand t)
;; the best package ever
(use-package magit :ensure t :demand t)

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


(provide 'utility-init)
