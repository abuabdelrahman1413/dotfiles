(defun set-bidi-env ()
  "interactive"
  (setq bidi-paragraph-direction 'nil))
(add-hook 'org-mode-hook 'set-bidi-env)

;; Install straight.el
   (defvar bootstrap-version)
   (let ((bootstrap-file
           (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
          (bootstrap-version 6))
      (unless (file-exists-p bootstrap-file)
        (with-current-buffer
            (url-retrieve-synchronously
             "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
             'silent 'inhibit-cookies)
          (goto-char (point-max))
          (eval-print-last-sexp)))
      (load bootstrap-file nil 'nomessage))

  (setq straight-use-package-by-default t)

(setq straight-vc-git-default-clone-depth 1)

(use-package evil
  :straight t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :straight t
  :config
  (evil-collection-init))

(use-package general
       :config
       (general-evil-setup)

       ;; set up 'SPC' as the global leader key
       (general-create-definer Mohammed/leader-keys
         :states '(normal insert visual emacs)
         :keymaps 'override
         :prefix "SPC" ;; set leader
         :global-prefix "M-SPC") ;; access leader in insert mode

     (Mohammed/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
     "." '(find-file :wk "Find file")
     "f c" '((lambda () (interactive) (find-file "~/.emacs.d/config.org")) :wk "Edit emacs config")
   "f r" '(counsel-recentf :wk "Find recent files")


     "TAB TAB" '(comment-line :wk "Comment lines")
     )

       (Mohammed/leader-keys
         "b" '(:ignore t :wk "buffer")
         "bb" '(switch-to-buffer :wk "Switch buffer")
         "bi" '(ibuffer :wk "list all buffers")
         "bk" '(kill-this-buffer :wk "Kill this buffer")
         "bn" '(next-buffer :wk "Next buffer")
         "bp" '(previous-buffer :wk "Previous buffer")
         "br" '(revert-buffer :wk "Reload buffer"))

  (Mohammed/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired")
    "d j" '(dired-jump :wk "Dired jump to current")
    "d n" '(neotree-dir :wk "Open directory in neotree")
    "d p" '(peep-dired :wk "Peep-dired"))


      (Mohammed/leader-keys
       "e" '(:ignore t :wk "Ediff/Eshell/Eval/EWW")    
       "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
       "e d" '(eval-defun :wk "Evaluate defun containing or after point")
       "e e" '(eval-expression :wk "Evaluate and elisp expression")
       "e f" '(ediff-files :wk "Run ediff on a pair of files")
       "e F" '(ediff-files3 :wk "Run ediff on three files")
       "e h" '(counsel-esh-history :which-key "Eshell history")
       "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
       "e n" '(eshell-new :wk "Create new eshell buffer")
       "e r" '(eval-region :wk "Evaluate elisp in region")
       "e R" '(eww-reload :which-key "Reload current page in EWW")
       "e s" '(eshell :which-key "Eshell")
       "e w" '(eww :which-key "EWW emacs web wowser"))

    (Mohammed/leader-keys
       "h" '(:ignore t :wk "Help")
       "h f" '(describe-function :wk "Describe function")
    "h t" '(load-theme :wk "Load theme")
       "h v" '(describe-variable :wk "Describe variable")
       "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :wk "Reload emacs config"))


(Mohammed/leader-keys
  "m" '(:ignore t :wk "Org")
  "m a" '(org-agenda :wk "Org agenda")
  "m e" '(org-export-dispatch :wk "Org export dispatch")
  "m i" '(org-toggle-item :wk "Org toggle item")
  "m t" '(org-todo :wk "Org todo")
  "m B" '(org-babel-tangle :wk "Org babel tangle")
  "m T" '(org-todo-list :wk "Org todo list"))

(Mohammed/leader-keys
  "m b" '(:ignore t :wk "Tables")
  "m b -" '(org-table-insert-hline :wk "Insert hline in table"))

(Mohammed/leader-keys
  "m d" '(:ignore t :wk "Date/deadline")
  "m d t" '(org-time-stamp :wk "Org time stamp"))

(Mohammed/leader-keys
  "p" '(projectile-command-map :wk "Projectile"))


 (Mohammed/leader-keys
   "t" '(:ignore t :wk "Toggle")
   "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
   "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t n" '(neotree-toggle :wk "Toggle neotree file viewer")

  "t v" '(vterm-toggle :wk "Toggle vterm"))



(Mohammed/leader-keys
   "w" '(:ignore t :wk "Windows")
   ;; Window splits
   "w c" '(evil-window-delete :wk "Close window")
   "w n" '(evil-window-new :wk "New window")
   "w s" '(evil-window-split :wk "Horizontal split window")
   "w v" '(evil-window-vsplit :wk "Vertical split window")
   ;; Window motions
   "w h" '(evil-window-left :wk "Window left")
   "w j" '(evil-window-down :wk "Window down")
   "w k" '(evil-window-up :wk "Window up")
   "w l" '(evil-window-right :wk "Window right")
   "w w" '(evil-window-next :wk "Goto next window")
   ;; Move Windows
   "w H" '(buf-move-left :wk "Buffer move left")
   "w J" '(buf-move-down :wk "Buffer move down")
   "w K" '(buf-move-up :wk "Buffer move up")
   "w L" '(buf-move-right :wk "Buffer move right"))


 )

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(require 'windmove)

;;;###autoload
(defun buf-move-up ()
  "Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled."
;;  "Switches between the current buffer, and the buffer above the
;;  split, if possible."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'up))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-down ()
"Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'down))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (or (null other-win) 
            (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
        (error "No window under this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-left ()
"Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'left))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No left split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-right ()
"Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'right))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No right split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

(use-package beacon)

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "/home/mohammed/.emacs.d/images/emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

;; Ensure straight.el is used for package management (if not already set up)
(setq straight-use-package-by-default t)
(setq straight-vc-git-default-clone-depth 1)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-url "https://github.com/radian-software/straight.el/raw/master/bootstrap.el"))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously bootstrap-url 'silent 'inhibit-cookies)
      (let ((bootstrap-el (buffer-string)))
	(with-temp-file bootstrap-file
	  (insert bootstrap-el)))))
  (load bootstrap-file))

;; Install necessary packages for LSP, auto-completion, and other language support
(straight-use-package 'use-package)

;; Install and configure lsp-mode for Go, Python, HTML, CSS, JavaScript, and TypeScript
(use-package lsp-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (python-mode . lsp-deferred)
	 (html-mode . lsp-deferred)
	 (css-mode . lsp-deferred)
	 (js-mode . lsp-deferred)
	 (typescript-mode . lsp-deferred))
  :commands lsp-deferred
  :config
  (setq lsp-enable-snippet t)            ;; Enable snippets for completion
  (setq lsp-idle-delay 0.1)              ;; Set idle delay before sending updates
  (setq lsp-completion-provider :capf)   ;; Use `capf` for better completion compatibility
  (setq lsp-headerline-breadcrumb-enable t) ;; Show breadcrumb navigation
  (setq lsp-signature-auto-activate t)   ;; Automatically show function signature
  (setq lsp-enable-indentation nil)      ;; Let Emacs handle indentation
  (setq lsp-enable-on-type-formatting nil)) ;; Disable on-type formatting

;; Install and configure lsp-ui for better LSP interface
(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t)       ;; Show diagnostics in the sideline
  (setq lsp-ui-doc-enable t)            ;; Show documentation popup
  (setq lsp-ui-doc-position 'at-point)  ;; Position documentation at point
  (setq lsp-ui-doc-delay 0.2)           ;; Delay before showing documentation
  (setq lsp-ui-sideline-show-hover t)   ;; Show hover information in the sideline
  (setq lsp-ui-sideline-show-code-actions t)) ;; Show code actions in the sideline

;; Install and configure company-mode for auto-completion
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.1)                ;; Delay before showing completion suggestions
  (setq company-minimum-prefix-length 1)       ;; Start completion after typing 1 character
  (setq company-tooltip-align-annotations t)   ;; Align annotations in the tooltip
  (setq company-show-numbers t)                ;; Show numbers for quick selection
  (setq company-tooltip-limit 55)              ;; Limit the number of suggestions in the tooltip
  (setq company-dabbrev-downcase nil)          ;; Do not convert suggestions to lowercase
  (setq company-dabbrev-ignore-case t)         ;; Ignore case when searching for suggestions

  ;; Enable navigation in the completion list using arrow keys
  (define-key company-active-map (kbd "<down>") #'company-select-next)
  (define-key company-active-map (kbd "<up>") #'company-select-previous)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection))

;; Add company-box for a modern completion UI
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-backends-colors nil)  ;; Disable background coloring for completion
  (setq company-box-doc-enable t)        ;; Enable documentation in the completion tooltip
  (setq company-box-scrollbar nil))       ;; Disable the scrollbar in the tooltip

;; Install and configure flycheck for linting
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))

;; Install and configure go-mode for Go development
(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode)
  :config
  (setq tab-width 4)                        ;; Set tab width to 4 spaces for Go
  (add-hook 'before-save-hook 'gofmt-before-save) ;; Format Go code on save
  (setq gofmt-command "goimports"))         ;; Use goimports for Go formatting

;; Install and configure python-mode for Python development
(use-package python-mode
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :config
  (setq python-indent-offset 4))            ;; Set Python indent offset to 4 spaces

;; Install and configure web-mode for HTML, CSS, JavaScript, and TypeScript
(use-package web-mode
  :ensure t
  :mode ("\\.html?\\'" . web-mode)
  :mode ("\\.css\\'" . web-mode)
  :mode ("\\.js\\'" . web-mode)
  :mode ("\\.ts\\'" . web-mode)
  :config
  (setq web-mode-enable-auto-pairing t)      ;; Auto-close brackets
  (setq web-mode-enable-auto-closing t)     ;; Auto-close HTML tags
  (setq web-mode-enable-auto-opening t))    ;; Auto-open matching tags

;; Enable company-web for better auto-completion in web-mode
(use-package company-web
  :ensure t
  :after (company web-mode)
  :config
  (add-to-list 'company-backends 'company-web-html)) ;; Add web-html to company backends

;; Install and configure lsp-pyls for Python LSP (if needed)
;; (use-package lsp-pyls
;;   :ensure t
;;   :config
;;   (setq lsp-pyls-plugins-flake8-enabled t)) ;; Enable flake8 linting in Python LSP

(use-package diminish)

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
)

;;(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1))

(set-face-attribute 'default nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Ubuntu"
  :height 120
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

;; show hidden files

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)

(require 'org-tempo)

(use-package projectile
  :config
  (projectile-mode 1))

(use-package rainbow-mode
  :hook org-mode prog-mode)
(use-package rainbow-delimiters
:hook ((org-mode . rainbow-delimiters-mode)
       (prog-mode . rainbow-delimiters-mode)))

;; Sets the default theme to load!!! 
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t)) ; if nil, italics is universally disabled

  (load-theme 'doom-one t)

(add-to-list 'default-frame-alist '(alpha-background . 80)) ; For all new frames henceforth

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.
  
(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package vterm
:config
(setq shell-file-name "/usr/bin/fish"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.3))))

(use-package sudo-edit
  :config
    (Mohammed/leader-keys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))

(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 0.5
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit nil
	which-key-separator " → " ))
