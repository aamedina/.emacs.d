(require 'cider-client)
(require 'nrepl-client)

(add-hook 'nrepl-connected-hook 'nrepl-discover)

(global-set-key (kbd "C-c C-t") 'nrepl-toggle-trace)

(provide 'cljs)
