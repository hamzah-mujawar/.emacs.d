;;Initialise elpaca before anything else
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'bootstrap-elpaca)

;; Some basic settings
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode -1)
(set-fringe-mode 10)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(setq-default line-spacing 0.2)

;; Disable line numbers on some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(show-paren-mode 1)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)
(set-face-attribute 'default nil :height 160 :family "CaskaydiaCove Nerd Font Mono")
(setq backup-directory-alist '(("," . "~/.emacs_saves"))) 

;; transparency
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; Org Mode Settings
(setq org-ellipsis " ▾"
      org-startup-folded 'content
      org-cycle-separator-lines 2
      org-fontify-quote-and-verse-blocks t)

;;Setting up nerd-icons prereq for doom-modeline
(use-package nerd-icons :ensure t)

;;doom-modeline needs to load before any other packages
;; TODO find a way to tuck it away into another file
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Packages, functions, etc.
(require 'completion-init)
(require 'theme-init)
(require 'utility-init)
(require 'lsp-init)

;; Custom
(custom-set-faces
 ;; ...
 '(js2-object-property ((t (:inherit font-lock-variable-name-face)))))
