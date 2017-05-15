(require 'package)

(setq package-enable-at-startup nil)

  (setq package-archives
        '(("gnu" . "https://elpa.gnu.org/packages/")
          ("melpa" . "https://melpa.org/packages/")
          ("elpy" . "https://jorgenschaefer.github.io/packages/")
          ("org" . "http://orgmode.org/elpa/")))

  (package-initialize)

  (package-refresh-contents)

  ;;Bootstrap `use-package'
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  (unless (package-installed-p 'dash)
    (package-refresh-contents)
    (package-install 'dash))

  (unless (package-installed-p 'seq)
    (package-refresh-contents)
    (package-install 'seq))

;  (require 'dash)
;  (require 'seq)

