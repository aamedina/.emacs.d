(require 'cedet)
(require 'cedet-files)
(setq semantic-load-turn-useful-things-on t)
(global-ede-mode 1)
(require 'semantic)
(semantic-mode 1)
(require 'semantic/sb)
(load "semantic/loaddefs.el")
;; (require 'malabar-mode)
(require 'srecode)

;; (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

(global-semanticdb-minor-mode 1)
(global-semantic-decoration-mode 1)
(global-semantic-highlight-func-mode 1)
(global-semantic-stickyfunc-mode -1)
(global-semantic-mru-bookmark-mode 1)

'(semantic-complete-inline-analyzer-displayor-class
  (quote semantic-displayor-tooltip))
'(semantic-complete-inline-analyzer-idle-displayor-class
  (quote semantic-displayor-tooltip))

(global-semantic-idle-completions-mode 1)
(global-semantic-idle-scheduler-mode 1)

(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes
             'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)

(semantic-add-system-include "/usr/local/opt/llvm/include/llvm" 'c++-mode)
(semantic-add-system-include "/usr/local/opt/llvm/include/llvm" 'objc-mode)
(semantic-add-system-include "/usr/local/opt/llvm/include/llvm-c" 'objc-mode)
(semantic-add-system-include "/usr/local/opt/llvm/include/llvm-c" 'c-mode)
(semantic-add-system-include "/usr/local/include/boost" 'c++-mode)
(semantic-add-system-include "/usr/local/include/boost" 'c-mode)
(semantic-add-system-include "/usr/local/include/boost" 'objc-mode)
