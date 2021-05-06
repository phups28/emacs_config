;; WORKSPACE DIRECTORY
(setq CURRENT_WORKSPACE_DIRECTORY "H:/Work/_proj") ;; projectile-discover-projects-in-directory
(setq default-directory CURRENT_WORKSPACE_DIRECTORY)

;; OPTIONS
(menu-bar-mode -1) 
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(setq visible-bell 1)
(setq inhibit-startup-message t)
(setq make-backup-files nil) ;;(setq backup-directory-alist '((".*" . "~/.Trash")))
(cua-mode t)
(global-auto-revert-mode t)
(desktop-save-mode 1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; THEMES
(set-face-attribute 'default nil :font "Consolas-174" :height 120)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'naysayer t)

;; CUSTOM KEY BINDING
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-j") 'backward-char)
(global-set-key (kbd "C-k") 'next-line)
(global-set-key (kbd "C-l") 'forward-char)
(global-set-key (kbd "C-i") 'previous-line) 
(global-set-key (kbd "C-w") 'kill-line)
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-/") 'delete-other-windows)
(global-set-key (kbd "C-p") 'delete-window)
(global-set-key (kbd "C-b") 'switch-to-buffer)
(global-set-key (kbd "C-q") 'move-beginning-of-line)
(global-set-key (kbd "C-e") 'move-end-of-line)
(global-set-key (kbd "C-x j") 'previous-buffer)
(global-set-key (kbd "C-x l") 'next-buffer)
(global-set-key (kbd "C-x t") 'projectile-find-file-other-window)
(global-set-key (kbd "C-,") (lambda () (interactive)(split-window-right) (other-window 1)))
(global-set-key (kbd "C-.") (lambda () (interactive)(split-window-below) (other-window 1)))
(global-set-key (kbd "C-]") (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "C-t") 'projectile-find-file)

(global-set-key [f5] 'projectile-compile-project)
(global-set-key [f6] 'magit)
(global-set-key [f7] 'projectile-run-shell)
(global-set-key [f9] 'global-display-line-numbers-mode)

;; TAB INDENT
(setq tab-width 4) ;;(setq-default indent-tabs-mode t)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(defun my-insert-tab-char () "Insert a tab char. (ASCII 9, \t)" (interactive)(insert "\t"))
(global-set-key (kbd "<tab>") 'my-insert-tab-char)

(defun my-indent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(global-set-key (kbd ">") 'my-indent-region)
(global-set-key (kbd "<") 'my-unindent-region)

;; INITIALIZE PACKAGE SOURCES
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("C-f" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-k" . ivy-next-line)
         ("C-i" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-f" . projectile-command-map)
  :init
  (when (file-directory-p CURRENT_WORKSPACE_DIRECTORY)
    (setq projectile-project-search-path nil)))
  ;; (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  ;; :after projectile
  ;; :bind (("C-M-p" . counsel-projectile-find-file))
  :config
  (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package ripgrep :ensure t)

;; C_SHARP MODE
(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs :ensure t)

(use-package csharp-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode)))

(defun my-csharp-mode-hook ()
  ;; enable the stuff you want for C# here
  (electric-pair-mode 1)       ;; Emacs 24
  (electric-pair-local-mode 1) ;; Emacs 25
  )
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

;; VUE MODE
(use-package vue-mode :ensure t)	

(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

;; RUST MODE
(use-package rust-mode :ensure t)
(require 'rust-mode)
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))


;; ------DO NOT CHANGE---------------------------------------------------------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rust-mode vue-mode lsp-mode csharp-mode projectile-variable treemacs-projectile counsel-projectile projectile magit rg swiper use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; -----------------------------------------------------------------------------------------------------------------------------------------------

