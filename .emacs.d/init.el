;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
;;(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; enable evil-mode
(require 'evil)
;;  (evil-mode 1)

;; (tool-bar-mode 1)

(setq evil-want-fine-undo 'fine)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(ac-config-default)

;; use web-mode for .html files
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;; use web-mode for .js files
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; use web-mode for .sass files
(add-to-list 'auto-mode-alist '("\\.sass$" . scss-mode))

;; use web-mode for .less files
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))

;; use web-mode for .css files
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(json-jsonlist)))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eclim-eclipse-dirs (quote ("/home/spak/opt/eclipse")))
 '(eclim-executable "/home/spak/opt/eclipse/eclim")
 '(jdee-server-dir "/home/spak/opt/java/jars/jdee-server.jar")
 '(markdown-command "markdown_py")
 '(tide-node-executable "/home/spak/opt/node-v6.11.2-linux-x64/bin/node"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setenv "IPY_TEST_SIMPLE_PROMPT" "1")

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  ;;(company-mode +1))

;; aligns annotation to the right hand side
;;(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; TSX tide mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; JSX tide
(add-hook 'js2-mode-hook #'setup-tide-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; use jade-mode for .pug files
(add-to-list 'auto-mode-alist '("\\.pug$" . jade-mode))

(add-hook 'js2-mode-hook 'ac-js2-mode)

(fset 'yes-or-no-p 'y-or-n-p)


(setq auto-save-file-name-transforms '((".*" "~/.emacs.bak/\\1" t)))
(setq backup-directory-alist `((".*" . ,"~/.emacs.bak/")))



(add-to-list 'load-path "/home/spak/opt/java/jars/jdee-server.jar")
  (require 'jdee)

(require 'eclim)
;;(setq eclimd-autostart t)

(defun my-java-mode-hook ()
    (eclim-mode t))

;;(add-hook 'java-mode-hook 'my-java-mode-hook)



(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(require 'ac-emacs-eclim)

;;(ac-emacs-eclim-config)

;; Turn on the menu bar for exploring new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

;; Use shell-like backspace C-h, rebind help to F1
(define-key key-translation-map [?\C-h] [?\C-?])

(require 'ng2-mode)

(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;; Key binding
(setq tss-popup-help-key "C-:")
(setq tss-jump-to-definition-key "C->")
(setq tss-implement-definition-key "C-c i")
(require 'tss)
(tss-config-default)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


;; Gtags/Global
(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)


;; Magit
(global-set-key (kbd "C-x g") 'magit-status)



;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;(exec-path-from-shell-copy-env "PYTHONPATH")
;;;init.el
