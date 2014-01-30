;; Copyright © 2014 Adrian Medina

;; inspired by Technomancy's emacs dotfiles
;; https://github.com/technomancy/dotfiles/blob/master/.emacs.d

(require 'cl)

(setq ido-use-virtual-buffers t
      inhibit-startup-message t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(defvar dependencies
  '(better-defaults
    clojure-mode
    clojure-test-mode
    find-file-in-project
    paredit
    magit
    markdown-mode
    smex
    diminish))

(dolist (p dependencies)
  (when (not (package-installed-p p))
    (package-install p)))

(mapc 'load (directory-files (concat user-emacs-directory user-login-name)
                             t "^[^#].*el$"))

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)

(defalias 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)

(zb)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
