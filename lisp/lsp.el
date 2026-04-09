;; Enable Corfu completion UI
;; See the Corfu README for more configuration tips.
(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-quit-at-boundary t)
  (corfu-quit-no-match nil)
  (corfu-on-exact-match nil)
  (setq corfu-auto-delay 0.2)
  :hook
  ((prog-mode . corfu-mode)
   (nix-mode . corfu-mode)
   (org-mode . corfu-mode))
  :init
  (global-corfu-mode))

;; Add extensions
(use-package cape
  :ensure t
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
   )

(unload-feature 'eldoc t)
(setq custom-delayed-init-variables '())
(defvar global-eldoc-mode nil)

(elpaca eldoc
  (require 'eldoc)
  (global-eldoc-mode))

;; Installing eglot and flymake
(use-package flymake :ensure t)

(use-package eglot :ensure t
  :custom
  (eglot-stay-out-of '(yasnippet)))


(add-hook 'prog-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'eglot-format nil t)))

(use-package nix-ts-mode :ensure t
  :mode "\\.nix\\'")

(use-package flymake-jsts
  :ensure '(flymake-jsts :type git :host github :repo "orzechowskid/flymake-jsts" :branch "main")
  :custom
  (flymake-jsts/debug 1))

(use-package css-in-js-mode
  :ensure '(css-in-js-mode :type git :host github :repo "orzechowskid/tree-sitter-css-in-js")
  :custom
  (css-in-js-mode-fetch-shared-library t))
  
(use-package tsx-mode
  :ensure '(tsx-mode :type git :host github :repo "orzechowskid/tsx-mode.el" :branch "emacs30")
  :defer t
  :mode "\\.tsx\\'"
  :custom
  (tsx-mode-enable-css-in-js t))
 
(add-to-list 'auto-mode-alist '("\\.[jt]s[x]?\\'" . tsx-mode))

(use-package lsp-mode :ensure t :hook ((lsp-mode . lsp-enable-which-key-integration)))

;; configuring eglot to work tinymist and nixd
(with-eval-after-load 'eglot
  (dolist (mode '((nix-mode . ("nixd"))))
    (add-to-list 'eglot-server-programs mode))
  (with-eval-after-load 'typst-ts-mode
    (dolist (mode '((typst-ts-mode . ("tinymist"))))
      (add-to-list 'eglot-server-programs mode))))

(add-hook 'typst-ts-mode-hook 'eglot-ensure)
(add-hook 'nix-ts-mode-hook 'eglot-ensure)

(use-package qml-ts-mode
  :ensure nil
  :mode "\\.qml\\'")

(with-eval-after-load 'eglot
  (dolist (mode '((qml-ts-mode . ("qmlls"))))
    (add-to-list 'eglot-server-programs mode)))

(add-hook 'qml-ts-mode-hook 'eglot-ensure)

(use-package java-ts-mode
  :ensure nil
  :after eglot
  :hook ((java-ts-mode . eglot-ensure)
	 (java-mode . java-ts-mode))
  :config
  (add-to-list 'major-mode-remap-alist '(java-mode . java-ts-mode)))

(use-package kdl-mode
  :ensure t
  :mode "\\.kdl\\'")


(use-package yasnippet :ensure t
  :config
  (yas-global-mode 1)
  (define-key yas-minor-mode-map (kbd "C-c TAB") 'yas-expand))

(use-package ggtags :ensure t
  :config
  (add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1)
	      )))
  (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
  (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
  (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
  (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
  (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
  (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
  (define-key ggtags-mode-map (kbd "C-c g t") 'ggtags-find-definition)
  (define-key ggtags-mode-map (kbd "M-?")     'ggtags-show-definition)
  (define-key ggtags-mode-map (kbd "M-,")     'pop-tag-mark)
  (add-hook 'c++-ts-mode-hook (lambda()
			  (ggtags-mode 1))))

(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))

(with-eval-after-load 'eglot
  (dolist (mode '((c++-ts-mode . ("ccls"))))
    (add-to-list 'eglot-server-programs mode)))

(add-hook 'c++-ts-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package org-block-capf
  :ensure '(org-block-capf :type git :host github :repo "xenodium/org-block-capf")
  :after org
  :hook (org-mode . org-block-capf-add-to-completion-at-point-functions))


(provide 'lsp)
