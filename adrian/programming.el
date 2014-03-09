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

;; Initalize autocomplete
(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(require 'auto-complete-clang-async)

(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(add-to-list 'load-path "~/.emacs.d/adrian")

(require 'xcscope)
(setq cscope-index-recursively t)

(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")
(global-set-key (kbd "M-/") 'auto-complete)
(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map "\r" nil)
(setq ac-quick-help-delay 0)
(setq ac-expand-on-auto-complete nil)

(defun ac-cc-mode-setup ()
  (let ((opts (shell-command-to-string
               "/usr/local/opt/llvm/bin/llvm-config --cxxflags --ldflags")))
    (yas/minor-mode-on)
    (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
    (setq clang-completion-supress-error 't)
    (setq ac-clang-cflags (split-string opts))
    (setq ac-clang-cflags (append '("-std=c++11") ac-clang-cflags))
    (setq ac-sources (append '(ac-source-clang-async
                               ac-source-yasnippet
                               ac-source-semantic
                               ac-source-words-in-same-mode-buffers
                               ac-source-gtags) ac-sources))
    (ac-clang-launch-completion-process)))

;; c config
(add-hook 'c-mode-hook 'ac-cc-mode-setup)
(add-hook 'c++-mode-hook 'ac-cc-mode-setup)
(add-hook 'objc-mode-hook 'ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(add-hook 'c-mode-common-hook 'adaptive-wrap-prefix-mode)
(add-hook 'c-mode-common-hook (lambda ()
                                (setq adaptive-wrap-extra-indent 4)))

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; ;; c++ config
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
(require 'ac-nrepl)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t
      cider-popup-stacktraces nil
      cider-repl-print-length 1000)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'cider-repl-mode))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook
          'set-auto-complete-as-completion-at-point-function)

(add-hook 'cider-repl-mode-hook
          'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)

;; flymake config
(eval-after-load 'flymake
  '(setq flymake-no-changes-timeout 5.0))

;; ;; haskell config
(require 'haskell-ac)
(add-to-list 'ac-modes 'haskell-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)

;; javascript config
(require 'js2-mode)

(setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "goog"))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/tern/emacs/"))
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook 'ac-js2-mode)
`(setq ac-js2-evaluate-calls t)'
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

;; mouse config
;; (defun smooth-scroll (number-lines increment)
;;   (if (= 0 number-lines)
;;       t
;;     (progn
;;       (sit-for 0.02)
;;       (scroll-up increment)
;;       (smooth-scroll (- number-lines 1) increment))))

;; (defun set-smooth-scroll ()
;;   ;; The scrolling experience is good enough
;;   (unless (fboundp 'mac-mwheel-scroll)
;;     (if (window-system)
;;         (progn
;;           (global-set-key (kbd "<wheel-down>")
;;                           (lambda () (interactive) (smooth-scroll 3 1)))
;;           (global-set-key (kbd "<wheel-up>")
;;                           (lambda () (interactive) (smooth-scroll 3 -1)))))
;;     (progn
;;       (global-set-key [(mouse-5)]
;;                       (lambda () (interactive) (smooth-scroll 3 1)))
;;       (global-set-key [(mouse-4)]
;;                       (lambda () (interactive) (smooth-scroll 3 -1))))))

;; (defun set-text-mode-mouse-options ()
;;   ;; Enable mouse
;;   (require 'mouse)
;;   (xterm-mouse-mode t)
;;   (defun track-mouse (e))
;;   (setq mouse-sel-mode t)

;;   (set-smooth-scroll))

;; (defun set-window-system-mouse-options ()
;;   (set-smooth-scroll))

;; (if (window-system)
;;     (set-window-system-mouse-options)
;;   (set-text-mode-mouse-options))

;; objective-c config
(define-key objc-mode-map (kbd "C-c m") 'search-objc-selector)
(define-key objc-mode-map (kbd "C-c f") 'search-objc-name)

(require 'docsetutil)
(setq docsetutil-program
      "/Applications/Xcode.app/Contents/Developer/usr/bin/docsetutil")
(setq docsetutil-browse-url-function 'w3m-browse-url)

(defun get-objc-selector-raw ()
  (let ((ignore-set '("@"))
        (skip-set '("(" "{" "[" "\"" "'"))
        (accum "")
        (stay t)
        (char (lambda ()
                (buffer-substring-no-properties
                 (point) (+ 1 (point))))))
    (while stay
      (cond ((member (funcall char) skip-set)
             (progn
               (forward-sexp)))
            ((member (funcall char) ignore-set)
             (progn
               (forward-char)))
            ((string-equal (funcall char) "]")
             (progn
               (setq stay nil)))
            (t
             (progn
               (setq accum (concat accum (funcall char)))
               (forward-char)))))
    accum))

(defun get-objc-selector ()
  (save-excursion
    (up-list)
    (backward-list)
    (down-list)

    (let* ((raw (get-objc-selector-raw))
           (has-args (string-match ":" raw))
           (cleaned "")
           (args-regex "\\([a-zA-Z]+\\)[ \t\n]*:")
           (noargs-regex "[a-zA-Z]+")
           (start-point 0))
      (cond (has-args
             (while (string-match args-regex raw start-point)
               (setq cleaned (concat cleaned (match-string 1 raw) ":"))
               (setq start-point (match-end 0))))
            (t
             (while (string-match noargs-regex raw start-point)
               (setq start-point (match-end 0))
               (setq cleaned (match-string 0 raw)))))
      cleaned)))

(defun search-objc-selector ()
  (interactive)
  (let ((name (get-objc-selector)))
    (docsetutil-search name)))

(defun search-objc-name ()
  (interactive)
  (docsetutil-search (thing-at-point 'symbol)))

(push '("\\.mm?\\'" objc-xcode-flymake-init) flymake-allowed-file-name-masks)

(add-hook 'objc-mode-hook 'visual-line-mode)
(add-hook 'objc-mode-hook 'adaptive-wrap-prefix-mode)
(add-hook 'objc-mode-hook (lambda ()
                            (setq adaptive-wrap-extra-indent 2)))

(add-to-list 'magic-mode-alist
             `(,(lambda ()
                  (and (string= (file-name-extension buffer-file-name) "h")
                       (or (re-search-forward "@\\<interface\\>"
                                              magic-mode-regexp-match-limit
                                              t)
                           (re-search-forward "@\\<protocol\\>"
                                              magic-mode-regexp-match-limit
                                              t))))
               . objc-mode))

(require 'find-file)
(nconc (cadr (assoc "\\.h\\'" cc-other-file-alist)) '(".m" ".mm"))
(add-to-list 'cc-other-file-alist '("\\.m\\'" (".h")))
(add-to-list 'cc-other-file-alist '("\\.mm\\'" (".h")))

(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))

(with-no-warnings (let ((w3m-command nil)) (require 'anything-config)))

(defvar anything-c-source-objc-headline
  '((name . "Objective-C Headline")
    (headline . "^[ \t]*[-+@]\\|^#pragma[ \t]+mark"))
  "Configuration for Objective-C headline.")

(defun objc-headline ()
  (interactive)
  (let ((anything-candidate-number-limit 500))
    (anything-other-buffer '(anything-c-source-objc-headline)
                           "*ObjC Headline*")))

(add-to-list 'ac-modes 'objc-mode)

(defun objc-xcode-build ()
  "Attempt to build the project."
  (interactive)
  (compile (concat "xcodebuild -configuration Debug -project "
                   (find-xcode-proj))))

(defun objc-xcode-flymake-filter (process output)
  (let ((source-buffer (process-buffer process)))
    (flymake-log 3 "received %d byte(s) of output from process %d"
                 (length output) (process-id process))
    (when (buffer-live-p source-buffer)
      (with-current-buffer source-buffer
        (flymake-parse-output-and-residual output)))))

(defun objc-xcode-flymake-sentinel (process _event)
  (when (memq (process-status process) '(signal exit))
    (flymake-parse-residual)
    (setq flymake-err-info flymake-new-err-info)
    (setq flymake-new-err-info nil)
    (setq flymake-err-info
          (flymake-fix-line-numbers
           flymake-err-info 1 (flymake-count-lines)))
    (flymake-delete-own-overlays)
    (flymake-highlight-err-lines flymake-err-info)
    (let (err-count warn-count (exit-status (process-exit-status process)))
      (setq err-count (flymake-get-err-count flymake-err-info "e"))
      (setq warn-count  (flymake-get-err-count flymake-err-info "w"))
      (flymake-log 2 "%s: %d error(s), %d warning(s)"
                   (buffer-name) err-count warn-count)
      (setq flymake-check-start-time nil)

      (if (and (equal 0 err-count) (equal 0 warn-count))
          (if (equal 0 exit-status)
              (flymake-report-status "" "")	; PASSED
            (flymake-report-status nil ""))) ; "STOPPED"
      (flymake-report-status (format "%d/%d" err-count warn-count) ""))))


(defun objc-xcode-flymake-init ()
  (let ((process
         (apply 'start-file-process "flymake-proc" (current-buffer)
                "xcodebuild" `("-configuration" "Debug"
                               "-project" ,(find-xcode-proj)))))
    (set-process-filter process 'objc-xcode-flymake-filter)
    (set-process-sentinel process 'objc-xcode-flymake-sentinel)
    nil))

(defun find-xcode-proj ()
  (if (directory-files "." t ".*\.xcodeproj$" nil)
      (nth 0 (directory-files "." t ".*\.xcodeproj$" nil))
    (let ((old-dir default-directory))
      (cd "../")
      (let ((result (find-xcode-proj)))
        (cd old-dir)
        result))))

;; java config

