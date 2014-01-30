(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)

(set-default 'c-basic-offset 2)

(setq lisp-modes '(lisp-mode
                   emacs-lisp-mode
                   common-lisp-mode
                   scheme-mode
                   clojure-mode
		   cider-repl-mode))

(defvar lisp-power-map (make-keymap))

(define-minor-mode lisp-power-mode
  :lighter " (power)"
  :keymap lisp-power-map
  (paredit-mode t))
(define-key lisp-power-map [delete] 'paredit-forward-delete)
(define-key lisp-power-map [backspace] 'paredit-backward-delete)

(defun lisp-power ()
  (lisp-power-mode t))

(dolist (mode lisp-modes)
  (add-hook (intern (format "%s-hook" mode))
            #'engage-lisp-power))

(setq inferior-lisp-program "clisp")
(setq scheme-program-name "racket")

(eval-after-load 'lisp-power
  '(diminish lisp-power-mode))

