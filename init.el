(setq inhibit-startup-message t)

(menu-bar-mode -1) 

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(setq visible-bell 1)
(cua-mode t)
(desktop-save-mode 1)
(set-face-attribute 'default nil :font "Consolas-174" :height 120)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq inhibit-startup-message t)

(menu-bar-mode -1) 

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(setq visible-bell 1)
;(global-display-line-numbers-mode t)
(cua-mode t)
(set-face-attribute 'default nil :font "Consolas-174" :height 120)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(load-theme 'naysayer t)

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
(global-set-key (kbd "C-n") (lambda () (interactive)(split-window-right) (other-window 1)))
(global-set-key (kbd "C-,") (lambda () (interactive)(split-window-below) (other-window 1)))

;; Initialize package sources
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
  ("C-t" . projectile-command-map)
  :init
  (when (file-directory-p "D:/Projects")
    (setq projectile-project-search-path '("D:/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :bind (("C-M-p" . counsel-projectile-find-file))
  :config
  (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(projectile-variable treemacs-projectile counsel-projectile projectile magit rg swiper use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

