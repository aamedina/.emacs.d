;; ;; nrepl.el 

;; (require 'cider-client)
;; (require 'nrepl-client)
;; (require 'nrepl-discover)
;; (require 'skewer-mode)

;; (defvar repl-env nil)

;; (defun cljs-browser-repl ()
;;   (interactive)
;;   (setq repl-env `((,httpd-port . ,(run-skewer)))))

;; (defun cljs-repl ()
;;   (interactive)
;;   (when (nrepl-current-session)
;;     (setq repl-env `((,httpd-port . ,(skewer-run-phantomjs))))))

;; (provide 'nrepl)

;; (defun cljs-eval (sexp)
;;   (let ((result (cider-eval-and-get-value (format "%s" sexp)
;;                                           nrepl-buffer-ns
;;                                           (nrepl-current-tooling-session))))
;;     (insert result)))




