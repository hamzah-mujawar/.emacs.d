;; Some basic settings
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(setq-default line-spacing 0.2)
(global-auto-revert-mode t)
(show-paren-mode 1)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)
(add-to-list 'default-frame-alist
             '(font . "CaskaydiaMono NF-12"))
(setq treesit-font-lock-level 4)


;; disable pinch
(global-set-key (kbd "<pinch>") 'ignore)
(global-set-key (kbd "<C-wheel-up>") 'ignore)
(global-set-key (kbd "<C-wheel-down>") 'ignore)


;; Disable line numbers on some modes
(dolist (mode '(pdf-view-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; transparency
(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; Org Mode Settings
(setq org-ellipsis " ▾"
      org-startup-folded 'content
      org-cycle-separator-lines 2
      org-fontify-quote-and-verse-blocks t)

;; Add "lisp" folder to emacs user directory
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;; BEFORE we do anything else we want to configure elpaca
(require 'elpaca)

;; Then we load up meow (my favourite plugin)
(require 'meow-my-beloved)

;; Theme
(require 'theme-init)

;; Completion (Vertico, Orderless, etc.)
(require 'completion)

;; utilities
(require 'utility)

;; Load LSP stuff last
(require 'lsp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indent-guides-method 'character)
 '(package-selected-packages '(eglot magit nix-mode))
 '(warning-suppress-log-types '((org-element org-element-parser))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(action-lock-face ((t :inherit button)))
 '(howm-mode-keyword-face ((t :inherit org-link)))
 '(howm-mode-ref-face ((t :inherit org-link)))
 '(howm-mode-title-face ((t :inherit org-level-1)))
 '(howm-mode-wiki-face ((t :inherit org-link)))
 '(howm-reminder-deadline-face ((t :inherit org-scheduled-today)))
 '(howm-reminder-defer-face ((t :inherit org-scheduled)))
 '(howm-reminder-done-face ((t :inherit org-done)))
 '(howm-reminder-late-deadline-face ((t :inherit bold :inherit org-imminent-deadline)))
 '(howm-reminder-normal-face ((t :inherit org-default)))
 '(howm-reminder-scheduled-face ((t :inherit org-scheduled)))
 '(howm-reminder-today-face ((t :inherit bold :inherit org-scheduled-today)))
 '(howm-reminder-todo-face ((t :inherit org-todo)))
 '(howm-reminder-tomorrow-face ((t :inherit bold :inherit org-scheduled)))
 '(howm-simulate-todo-mode-line-face ((t :inherit bold)))
 '(howm-view-empty-face ((t :inherit shadow)))
 '(howm-view-hilit-face ((t :inherit isearch)))
 '(howm-view-name-face ((t :inherit org-document-title))))
(put 'dired-find-alternate-file 'disabled nil)
