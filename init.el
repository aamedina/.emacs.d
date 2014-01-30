;; Copyright © 2014 Adrian Medina

;; inspired by Technomancy's emacs dotfiles
;; https://github.com/technomancy/dotfiles/blob/master/.emacs.d

(require 'cl)

(setq ido-use-virtual-buffers t
      inhibit-startup-message t
      custom-file (expand-file-name "~/.emacs.d/custom.el"))

(load custom-file t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(defvar dependencies
  '(better-defaults
    autopair
    clojure-mode
    clojure-test-mode
    find-file-in-project
    paredit
    magit
    markdown-mode
    smex
    diminish
    js2-mode
    skewer-mode
    less-css-mode
    skewer-less
    ido-hacks))

(dolist (p dependencies)
  (when (not (package-installed-p p))
    (package-install p)))

(mapc 'load (directory-files (concat user-emacs-directory user-login-name)
                             t "^[^#].*el$"))

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)

(require 'ido-hacks)
(ido-hacks-mode)

(global-set-key (kbd "M-x") 'smex)

(defalias 'yes-or-no-p 'y-or-n-p)

(column-number-mode t)

(setq-default ispell-program-name "aspell")

(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))

(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'less-css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(zb)
