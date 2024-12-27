(tool-bar-mode -1)             ; Hide the outdated icons

(scroll-bar-mode -1)           ; Hide the always-visible scrollbar
(setq inhibit-splash-screen t) ; Remove the "Welcome to GNU Emacs" splash screen
(setq use-file-dialog nil)      ; Ask for textual confirmation instead of GUI



(defvar bootstrap-version)
(let ((bootstrap-file
    (expand-file-name
      "straight/repos/straight.el/bootstrap.el"
      (or (bound-and-true-p straight-base-dir)
        user-emacs-directory)))
    (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))




(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)
