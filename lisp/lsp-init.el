;; Enable company globally
(use-package company
  :ensure t
  :config
  (global-company-mode 1)
  ;; Optional: Tune company settings
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2
        company-selection-wrap-around t))

;; Built-in eglot setup
(add-hook 'prog-mode-hook 'eglot-ensure)

;; Ensure eglot integrates with company
(defun eglot-company-integration ()
  "Integrate eglot with company-mode."
  (add-to-list (make-local-variable 'company-backends) 'company-capf))

(add-hook 'eglot-managed-mode-hook #'eglot-company-integration)

;; Install js2-mode
(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :demand t)

(use-package tree-sitter
  :ensure t
  :demand t
  :config
  (require 'tree-sitter)
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode))

(use-package tree-sitter-langs :ensure t :demand t)

(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)


(provide 'lsp-init)
