(require 'cider-client)
(require 'nrepl-client)

(add-hook 'nrepl-connected-hook 'nrepl-discover)

(provide 'cljs)
