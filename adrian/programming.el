(add-hook 'prog-mode-hook 'hl-line-mode)

(set-default 'c-basic-offset 2)

(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-expand-on-auto-complete nil
              ac-auto-start nil
              ac-dwim nil)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(setq c-tab-always-indent nil
      c-insert-tab-function 'indent-for-tab-command)

(defun auto-complete-at-point ()
  (when (and (not (minibufferp))
             (fboundp 'auto-complete-mode)
             auto-complete-mode)
    (auto-complete)))


(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions
        (cons 'auto-complete-at-point
              (remove 'auto-complete-at-point completion-at-point-functions))))

(add-hook 'auto-complete-mode-hook
          'set-auto-complete-as-completion-at-point-function)

(add-hook 'cider-repl-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook
          'set-auto-complete-as-completion-at-point-function)

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
  (turn-on-eldoc-mode)
  (paredit-mode)
  (subword-mode))

(define-key lisp-power-map [delete] 'paredit-forward-delete)
(define-key lisp-power-map [backspace] 'paredit-backward-delete)

(defun lisp-power ()
  (lisp-power-mode t))

(dolist (mode lisp-modes)
  (add-hook (intern (format "%s-hook" mode)) #'lisp-power))

(setq inferior-lisp-program "clisp"
      scheme-program-name "racket")

(eval-after-load 'lisp-power
  '(diminish lisp-power-mode))

(setq nrepl-hide-special-buffers t
      cider-popup-stacktraces nil
      cider-repl-print-length 1000)

(autopair-global-mode)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "goog"))

(defun js2-tab-properly ()
  (interactive)
  (let ((yas-fallback-behavior 'return-nil))
    (unless (yas-expand)
      (indent-for-tab-command)
      (if (looking-back "^\s*")
          (back-to-indentation)))))

(require 'js2-mode)
(define-key js2-mode-map (kbd "TAB") 'js2-tab-properly)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/tern/emacs/"))
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'cider-repl-mode))
