;; Some basic settings
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(setq-default line-spacing 0.2)
(global-auto-revert-mode t)


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
(setq backup-directory-alist '(("." . "~/.emacs_saves/")))

;; transparency
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; Org Mode Settings
(setq org-ellipsis " ▾"
      org-startup-folded 'content
      org-cycle-separator-lines 2
      org-fontify-quote-and-verse-blocks t)

;;Initialise elpaca before anything else
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'bootstrap-elpaca)

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; ;;Setting up nerd-icons prereq for doom-modeline
(use-package nerd-icons :ensure t)

;; ;;doom-modeline needs to load before any other packages
;; ;; TODO find a way to tuck it away into another file
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;;Tramp workaround fix: https://stat.ethz.ch/pipermail/ess-help/2012-January/007396.html
(require 'tramp)
(require 'tramp-sh)
(tramp-set-completion-function "ssh"
   '((tramp-parse-sconfig "/etc/ssh_config")
     (tramp-parse-sconfig "~/.ssh/config")))

(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; Packages, functions, etc.
(require 'meow-my-beloved)
(require 'completion-init)
(require 'theme-init)
(require 'utility-init)
(require 'lsp-init)

;; Custom
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-object-property ((t (:inherit font-lock-variable-name-face)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69"
     "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e"
     default))
 '(package-selected-packages nil)
 '(warning-suppress-log-types '((elpaca core 30.0.92))))
