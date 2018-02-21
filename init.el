(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar mio-packages
  '(auto-complete
    helm
    helm-ls-git
    helm-gtags
    magit
    projectile
    ggtags
    ;;ivy
    swiper
    swiper-helm
    counsel
    counsel-gtags
    counsel-projectile
    ztree
    dired+
    bookmark+
    yasnippet
    iedit
    imenu+
    imenu
    smartparens
    f
    dtrt-indent
    restclient
    elpy
    flycheck
    jedi
    eimp
    web-mode
    log4j-mode
    helm-swoop
    paganini-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      mio-packages)

;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

(load-file "~/.emacs.d/thirdparty/tp-conf.el")
(load-file "~/.emacs.d/include/mio-conf.el")
