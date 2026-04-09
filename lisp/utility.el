(use-package vundo :ensure t)

(use-package typst-ts-mode
  :ensure (:type git :host codeberg :repo "meow_king/typst-ts-mode" :branch "develop")
  :custom
  (typst-ts-watch-options (list (concat "--root=" (expand-file-name "~/thesis_stuff/PLR_PDF/")) "--open"))
  (typst-ts-mode-grammar-location (expand-file-name "tree-sitter/libtree-sitter-typst.so" user-emacs-directory))
  (typst-ts-mode-enable-raw-blocks-highlight t)
  :config
  (keymap-set typst-ts-mode-map "C-c C-c" #'typst-ts-tmenu))

(defun save-and-export-typst ()
  (shell-command-to-string (format "tinymist compile --when onSave %s" (shell-quote-argument buffer-file-name))))

  (add-hook 'typst-ts-mode-hook (lambda ()
				  (add-hook 'after-save-hook #'save-and-export-typst nil t)))

(use-package jinx
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))

(use-package citar
  :ensure t
  :custom
  (citar-bibliography '("~/thesis_stuff/PLR_PDF/references.bib"))
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  (typst-ts-mode . citar-capf-setup))

(use-package citar-embark
  :ensure t
  :after citar embark
  :no-require
  :config (citar-embark-mode))

;; Magit depends on transient so installing this first
(use-package transient :ensure t)

(use-package magit
  :ensure t)

;; PDFs in Emacs!
(use-package pdf-tools :ensure t
  :config
  (pdf-tools-install)
  (setq pdf-view-use-scaling nil)
  (setq auto-revert-interval 0.5)
  (auto-revert-set-timer))

(use-package howm
  :ensure t
  :init
  ;; 
  ;; Options: Remove the leading ";" in the following lines if you like.
  ;; 
  ;; Format
  ;(require 'howm-markdown) ;; Write notes in markdown-mode. (*1)
  (require 'howm-org) ;; Write notes in Org-mode. (*2)
  ;; 
  ;; Preferences
  (setq howm-directory "~/notes") ;; Where to store the files?
  (setq howm-follow-theme t) ;; Use your Emacs theme colors. (*3)
  ;; 
  ;; Performance
  (setq howm-menu-expiry-hours 1) ;; Cache menu N hours. (*4)
  (setq howm-menu-refresh-after-save nil) ;; Speed up note saving. (*5)
  )

(use-package windmove
  :bind
  (("C-x k"    . my/windmove-or-sway-up)
   ("C-x j"  . my/windmove-or-sway-down)
   ("C-x h"  . my/windmove-or-sway-left)
   ("C-x l" . my/windmove-or-sway-right))
  :init
  (defun my/windmove-or-sway-up ()
    "Move window up with windmove, or sway focus left if windmove fails."
    (interactive)
    (condition-case nil
        (windmove-up)
      (error
       (shell-command "swaymsg focus up")
       (message "Used sway to focus up"))))
  (defun my/windmove-or-sway-down ()
    "Move window down with windmove, or sway focus left if windmove fails."
    (interactive)
    (condition-case nil
        (windmove-down)
      (error
       (shell-command "swaymsg focus down")
       (message "Used sway to focus down"))))
  (defun my/windmove-or-sway-left ()
    "Move window left with windmove, or sway focus left if windmove fails."
    (interactive)
    (condition-case nil
        (windmove-left)
      (error
       (shell-command "swaymsg focus left")
       (message "Used sway to focus left"))))
  (defun my/windmove-or-sway-right ()
    "Move window right with windmove, or sway focus left if windmove fails."
    (interactive)
    (condition-case nil
        (windmove-right)
      (error
       (shell-command "swaymsg focus right")
       (message "Used sway to focus right"))))
  )

(use-package wgrep :ensure t)

(use-package vterm :ensure t)

(use-package visual-regexp :ensure t
  :bind("C-M-%" . vr/query-replace))

(org-babel-do-load-languages 'org-babel-load-languages
                             (append org-babel-load-languages
                              '((C       .   t)
				(java    .   t))))

(use-package yasnippet-capf
  :ensure t
  :after cape yasnippet
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf)
  (defun my/eglot-capf-with-yasnippet ()
    (setq-local completion-at-point-functions
		(list
		 (cape-capf-super
		  #'eglot-completion-at-point
		  #'yasnippet-capf))))
  (with-eval-after-load 'eglot
    (add-hook 'eglot-managed-mode-hook #'my/eglot-capf-with-yasnippet)))

(use-package dape
  :ensure t
  :preface
  ;; By default dape shares the same keybinding prefix as `gud'
  ;; If you do not want to use any prefix, set it to nil.
  ;; (setq dape-key-prefix "\C-x\C-a")

  :hook
  ;; Save breakpoints on quit
  (kill-emacs . dape-breakpoint-save)
  ;; Load breakpoints on startup
  (after-init . dape-breakpoint-load)

  :custom
  ;; Turn on global bindings for setting breakpoints with mouse
  (dape-breakpoint-global-mode +1)

  ;; Info buffers to the right
  ;; (dape-buffer-window-arrangement 'right)
  ;; Info buffers like gud (gdb-mi)
  ;; (dape-buffer-window-arrangement 'gud)
  ;; (dape-info-hide-mode-line nil)

  ;; Projectile users
  ;; (dape-cwd-function #'projectile-project-root)

  :config
  ;; Pulse source line (performance hit)
  ;; (add-hook 'dape-display-source-hook #'pulse-momentary-highlight-one-line)

  ;; Save buffers on startup, useful for interpreted languages
  ;; (add-hook 'dape-start-hook (lambda () (save-some-buffers t t)))

  ;; Kill compile buffer on build success
  ;; (add-hook 'dape-compile-hook #'kill-buffer)
  )

;; For a more ergonomic Emacs and `dape' experience
(use-package repeat
  :custom
  (repeat-mode +1))

(use-package org-superstar
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))


(provide 'utility)
