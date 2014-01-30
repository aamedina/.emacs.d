(global-set-key (kbd "C-c C-f") 'find-file-in-project)

(global-set-key (kbd "C-c M-f") 'ido-find-file-other-window)

(global-set-key (kbd "C-c g") 'magit-status)

(global-set-key (kbd "C-c y") 'bury-buffer)

(global-set-key (kbd "C-c n")
                (defun pnh-cleanup-buffer () (interactive)
                  (delete-trailing-whitespace)
                  (untabify (point-min) (point-max))
                  (indent-region (point-min) (point-max))))

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)))
