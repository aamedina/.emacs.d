;; Copyright © 2014 Adrian Medina

;; inspired by Technomancy's emacs dotfiles
;; https://github.com/technomancy/dotfiles/blob/master/.emacs.d

(require 'cl)

(setq ido-use-virtual-buffers t
      inhibit-startup-message t
      custom-file (expand-file-name "~/.emacs.d/custom.el"))

(load custom-file t)

(add-to-list 'load-path "~/.emacs.d/site-lisp")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(defvar cider-dependencies 
  '(clojure-mode
    clojure-test-mode
    dash
    pkg-info))

(dolist (p cider-dependencies)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path "~/.emacs.d/cider")
(require 'cider)

(defvar dependencies
  '(better-defaults
    async
    auto-complete
    ac-js2
    ac-nrepl
    autopair
    find-file-in-project
    projectile
    paredit
    magit
    markdown-mode
    smex
    diminish
    js2-mode
    js2-refactor
    skewer-mode
    less-css-mode
    skewer-less
    ido-hacks
    htmlize
    yasnippet
    undo-tree
    visual-regexp-steroids
    slamhound
    emacs-eclim))

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
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.cljc$" . clojure-mode))

(setq phantomjs-program-name "/usr/local/bin/phantomjs")

(zb)

(require 'eclim)
(require 'eclimd)
(global-eclim-mode)

(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)
