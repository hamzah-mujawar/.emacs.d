(add-hook 'c-mode 'eglot-ensure)
(add-hook 'js-mode 'eglot-ensure)
(add-hook 'html-mode 'eglot-ensure)
(add-hook 'css-mode 'eglot-ensure)
(add-hook 'emacs-lisp-mode-hook 'eglot-ensure)

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

:;; Install js2-mode
(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :demand t)

(provide 'lsp-init)
