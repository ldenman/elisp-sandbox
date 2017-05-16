(require 'package)

(setq package-enable-at-startup nil)

  (setq package-archives
        '(("gnu" . "https://elpa.gnu.org/packages/")
          ("melpa" . "https://melpa.org/packages/")
          ("elpy" . "https://jorgenschaefer.github.io/packages/")
          ("org" . "http://orgmode.org/elpa/")))

;; load path for other packages
(package-initialize)


(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/elpa/")

;; Moved the custom.el stuff into its own file called ~/.emacs.d/customize.el
(setq custom-file "~/.emacs.d/customize.el")
(load custom-file t)

(require 'dash)
(require 'seq)
