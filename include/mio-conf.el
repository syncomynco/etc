(require 'auto-complete)
(require 'helm)
(require 'helm-ls-git)
(require 'smartparens-config)
(require 'swiper-helm)
;; theme
(setq inhibit-startup-message t) ;; hide the startup message
(global-linum-mode t) ;; enable line numbers globally
(load-theme 'paganini t)
;; (tool-bar-mode 1)

;; Auto-Complete
(ac-config-default)
;;(ivy-mode 1)
(setq magit-completing-read-function 'ivy-completing-read)
(setq projectile-completion-system 'ivy)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(projectile-mode 1)
(setq projectile-switch-project-action 'projectile-dired)
;;(setq projectile-indexing-method 'alien) ;; for Windows

(add-to-list 'load-path "~/.emacs.d/include/")
(require 'mio-keys)

(prefer-coding-system 'utf-8)
(defalias 'yes-or-no-p 'y-or-n-p)

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(add-hook 'java-mode-hook 'helm-gtags-mode)

(elpy-enable)
(setq elpy-rpc-backend "jedi")
;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode))

(push (substitute-in-file-name "path-to-ztree-directory") load-path)
(require 'ztree)

;; use web-mode for .html files
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
;; use web-mode for .js files
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
;; use web-mode for .sass files
(add-to-list 'auto-mode-alist '("\\.sass$" . web-mode))
;; use web-mode for .less files
(add-to-list 'auto-mode-alist '("\\.less$" . web-mode))
;; use web-mode for .css files
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))
