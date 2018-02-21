;; Global key-bindings
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-<f6>") 'helm-ls-git-ls)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(defun mio-insert-commit-date-time ()
  (interactive)
  (setq lpt (parse-time-string (current-time-string)))
  (insert (format "%02d/%02d/%02d %02d:%02d" (nth 3 lpt)(nth 4 lpt)(nth 5 lpt)(nth 2 lpt)(nth 1 lpt)))
  )

(define-key text-mode-map (kbd "C-q g") 'helm-grep-do-git-grep)
(define-key text-mode-map (kbd "C-q t") 'mio-insert-commit-date-time)
(define-key dired-mode-map (kbd "SPC") 'dired-subtree-toggle)
(with-eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

(defun mio-clear-logs ()
  (interactive)
  (end-of-buffer)
  (activate-mark)
  (beginning-of-buffer)
  (delete-region (point-min) (point-max))
  (write-file))


(defun mio-refresh-logs ()
  (interactive)
  (revert-buffer t t t)
  (toggle-truncate-lines))


;;(local-set-key (kbd "C-q") 'mio-insert-commit-date-time)
;;(add-hook 'text-mode-hook (lambda() (local-set-key (kbd "C-q t") 'mio-insert-commit-date-time)))
;;(add-hook 'projectile-mode-hook (lambda() (local-set-key (kbd "C-q g") 'helm-grep-do-git-grep)))
;; 
(provide 'mio)
(provide 'mio-keys)
