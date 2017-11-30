;; Melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Import Packages
(require 'auto-complete)
(require 'helm)
(require 'helm-ls-git)

(add-to-list 'load-path "~/.emacs.d/include/")
(require 'custom)

;; End Import Packages

;;;;; Look and Theme ;;;;
(setq inhibit-startup-message t) ;; hide the startup message
(global-linum-mode t) ;; enable line numbers globally

;; Load themes from directory
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'paganini t) ;; load material theme
;; (tool-bar-mode 1)
;;;;; End Look and Theme ;;;;;

;;;;; Variables ;;;;;
;; $PATH
;;(setenv "PATH" (concat (getenv "PATH") ":/new/path/dir"))

;;(setq shell-file-name "C:\Users\Spak\home\Git\git-bash.exe")
;;(setq explicit-shell-file-name shell-file-name)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;;;; End Variables ;;;;;

;; Auto-Complete
(ac-config-default)


(projectile-mode 1)
(setq projectile-indexing-method 'alien)



;; Key-bindings
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-<f6>") 'helm-ls-git-ls)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
