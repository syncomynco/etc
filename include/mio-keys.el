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
(global-set-key (kbd "C-x C-<f11>") #'mio/narrow-or-widen-dwim)
(global-set-key (kbd "C-<f12>") 'view-mode)

(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(defun mio-insert-date-time (&optional pfx)
  (interactive)
  (setq lpt (parse-time-string (current-time-string)))
  (insert (format "%s %02d/%02d/%02d %02d:%02d" pfx (nth 3 lpt)(nth 4 lpt)(nth 5 lpt)(nth 2 lpt)(nth 1 lpt)))
  )

(defun mio-insert-squash-date-time ()
  (interactive)
  (mio-insert-date-time "squash!"))

(define-key projectile-mode-map (kbd "C-q g") 'helm-grep-do-git-grep)
(define-key text-mode-map (kbd "C-q t") 'mio-insert-date-time)
(define-key text-mode-map (kbd "C-q s") 'mio-insert-squash-date-time)
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
  (revert-buffer t t t))


;;(local-set-key (kbd "C-q") 'mio-insert-date-time)
;;(add-hook 'text-mode-hook (lambda() (local-set-key (kbd "C-q t") 'mio-insert-date-time)))
;;(add-hook 'projectile-mode-hook (lambda() (local-set-key (kbd "C-q g") 'helm-grep-do-git-grep)))
;; 
(provide 'mio)
(provide 'mio-keys)

(use-package log4j-mode
  :ensure t
  :disabled t
  :init
  (add-hook #'log4j-mode-hook #'view-mode)
  (add-hook #'log4j-mode-hook #'read-only-mode))

(use-package view
  :config
  (defun View-goto-line-last (&optional line)
    "goto last line"
    (interactive "P")
    (goto-line (line-number-at-pos (point-max))))

  (define-key view-mode-map (kbd "w") 'View-scroll-half-page-forward)
  (define-key view-mode-map (kbd "s") 'View-scroll-half-page-backward)
  (define-key view-mode-map (kbd "g") 'mio-refresh-logs)
  ;; less like
  (define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
  (define-key view-mode-map (kbd "?") 'View-search-regexp-backward?)
  (define-key view-mode-map (kbd "<") 'View-goto-line)
  (define-key view-mode-map (kbd ">") 'View-goto-line-last)
  ;; vi/w3m like
  (define-key view-mode-map (kbd "b") 'backward-char)
  (define-key view-mode-map (kbd "n") 'next-line)
  (define-key view-mode-map (kbd "p") 'previous-line)
  (define-key view-mode-map (kbd "f") 'forward-char)
  (define-key view-mode-map (kbd "t") 'toggle-truncate-lines))

(defun mio/narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first. Narrowing to
org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning)
                           (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if
         ;; you don't want it.
         (cond ((ignore-errors (org-edit-src-code) t)
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))
