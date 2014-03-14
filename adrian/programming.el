(set-default 'c-basic-offset 2)
(yas-global-mode 1)
(autopair-global-mode)
(setq autopair-autowrap t)
(add-hook 'c-mode-hook 'subword-mode)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(setq ido-use-filename-at-point 'guess)

(add-hook 'prog-mode-hook
          (lambda ()
            (paredit-mode t)
            (turn-on-eldoc-mode)
            (eldoc-add-command 'paredit-backward-delete 'paredit-close-round)))

(add-hook 'cider-repl-mode-hook
          (lambda ()
            (paredit-mode t)
            (turn-on-eldoc-mode)
            (eldoc-add-command 'paredit-backward-delete 'paredit-close-round)))

(add-to-list 'load-path "~/.emacs.d/adrian")

;; c config

;; c++ config
(add-to-list 'magic-mode-alist
             `(,(lambda ()
                  (and (string= (file-name-extension buffer-file-name) "h")
                       (or (re-search-forward "class"
                                              magic-mode-regexp-match-limit
                                              t)
                           (re-search-forward "namespace"
                                              magic-mode-regexp-match-limit
                                              t)
                           (re-search-forward "virtual"
                                              magic-mode-regexp-match-limit
                                              t)
                           (re-search-forward "private:"
                                              magic-mode-regexp-match-limit
                                              t)
                           (re-search-forward "public:"
                                              magic-mode-regexp-match-limit
                                              t))))
               . c++-mode))

;; clojure config
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t
      cider-popup-stacktraces nil
      cider-repl-print-length 1000)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)

;; flymake config
(eval-after-load 'flymake
  '(setq flymake-no-changes-timeout 5.0))

;; ;; haskell config
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)
(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)

;; javascript config
(require 'js2-mode)
(setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "goog"))

;; objective-c config
