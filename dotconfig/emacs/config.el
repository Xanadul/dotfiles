(use-package evil
  :straight t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :straight t
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil)
)
(setq org-return-follows-link t)

(defun xan-remap-wdired-evil-ex ()
  "Changes evil-ex-commands (colon commands) of wdired mode.\nAdds :wq for saving edit."
  (make-local-variable 'evil-ex-commands)
  (setq evil-ex-commands
	  (mapcar (lambda (cmd) (cons (car cmd) (cdr cmd)))
		  (default-value 'evil-ex-commands)))
  (evil-ex-define-cmd "wq[uit]" 'wdired-finish-edit)
  (evil-ex-define-cmd "w[rite]" 'wdired-finish-edit) ;; TODO: Should not write and quit, but just write. Can't find the command though
  (evil-ex-define-cmd "q[uit]" 'wdired-exit)
  (evil-ex-define-cmd "q![uit]" 'wdired-abort-changes)
)
(add-hook 'wdired-mode-hook 'xan-remap-wdired-evil-ex)

(use-package general
  :straight t
  :config
  (general-evil-setup)
  (general-auto-unbind-keys) ;; Automatically unbinds already bound keys if necessary. Prevents "Key sequence starts with a non-prefix key" errors

 (general-create-definer xan/leader-keys
    :states '(normal visual emacs man motion)
    :keymaps 'override
    :prefix "SPC" ;;set leader
    :global-prefix "M-SPC") ;;access leader in insert mode

 (xan/leader-keys
    "b" '(:ignore t :wk "Buffer")
    "b b" '(switch-to-buffer :wk "Switch Buffer")
    "b i" '(ibuffer :wk "Ibuffer")
    "b p" '(switch-to-prev-buffer :wk "Switch to previous buffer")
    "b <up>" '(switch-to-prev-buffer :wk "Switch to previous buffer")
    "b <down>" '(switch-to-prev-buffer :wk "Switch to next buffer")
    "b k" '(kill-this-buffer :wk "Kill this Buffer")
    "b r" '(revert-buffer :wk "Reload Buffer"))

 (xan/leader-keys
   "d" '(:ignore t :wk "Describe")
   "d v" '(counsel-describe-variable :wk "Describe Variable")
   "d f" '(counsel-describe-function :wk "Describe Function")
   "d b" '(counsel-descbinds :wk "Describe Bindings")
   "d s" '(counsel-describe-symbol :wk "Describe Symbol")
   "d g" '(counsel-describe-face :wk "Describe Face (Gesicht)")
 )

 (xan/leader-keys
    "e" '(:ignore t :wk "Evaluate/Eshell")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e h" '(dante-eval-block :wk "Evaluate Haskell"))

 (xan/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "." '(find-file :wk "Find File")
    ":" '(sudo-edit-find-file :wk "Sudo find file")
    "f c" '(:ignore t :wk "Edit configs")
    "f c e" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
    "f c q" '((lambda () (interactive) (find-file "~/.config/qutebrowser/config.org")) :wk "Edit Qutebrowser config")
    "f c m" '((lambda () (interactive) (find-file "~/.config/mpv/mpv.conf")) :wk "Edit MPV config")
    "f c h" '((lambda () (interactive) (find-file "~/.config/hypr/hyprland.org")) :wk "Edit Hyprland config")
    "f c w" '(:ignore t :wk "Edit Waybar...")
    "f c w c" '((lambda () (interactive) (find-file "~/.config/waybar/config.json")) :wk "Edit Waybar config")
    "f c w s" '((lambda () (interactive) (find-file "~/.config/waybar/style.css")) :wk "Edit Waybar css")
    "f c w t" '((lambda () (interactive) (find-file "~/.config/wezterm/wezterm.lua")) :wk "Edit wezterm config")
    "f c z" '((lambda () (interactive) (find-file "~/.config/zsh/zshrc.org")) :wk "Edit zshrc config")
    "f r" '(counsel-recentf :wk "Find recent files")
    "f f" '(pophint:do :wk "Pophint do"))


 (xan/leader-keys
    "w" '(:ignore t :wk "Window")
    ;; Window splits
    "w h" '(split-window-horizontally :wk Split window horizontally)
    "w v" '(split-window-vertically :wk Split window vertically)
    "w c" '(evil-window-delete :wk Close current window)
    ;; Window Motions
    "w <left>" '(evil-window-left :wk Switch focus to the left)
    "w <down>" '(evil-window-down :wk Switch focus downwards)
    "w <up>" '(evil-window-up :wk Switch focus to upwards)
    "w <right>" '(evil-window-right :wk Switch focus to the right)
    "w w" '(evil-window-next :wk Switch focus to the next Window)
    "w W" '(evil-window-prev :wk Switch focus to the previous Window)
    ;; Window Moving
    "w S-<left>" '(buf-move-left :wk Buffer move left)
    "w S-<right>" '(buf-move-right :wk Buffer move right)
    "w S-<up>" '(buf-move-up :wk Buffer move up)
    "w S-<down>" '(buf-move-down :wk Buffer move down))

 (xan/leader-keys
    "m" '(:ignore t :wk "Media")
    "m r" '(:ignore t :wk "Eradio")
    "m r t" '(eradio-toggle :wk "Eradio toggle")
    "m r s" '(eradio-play :wk "Eradio select"))

 (xan/leader-keys
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describve variable")
    ;;"h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config")
    "h r r" '(reload-init-file :wk "Reload emacs config"))

 (xan/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t v" '(vterm-toggle :wk "Toggle Vterm")
    "t h" '(dired-hide-dotfiles-mode :wk "Dired Toggle dotfiles")
    "t i" '(imenu-list-smart-toggle :wk "Toggle imenu-list")
    "t c" '(org-toggle-checkbox :wk "Toggle org checkbox")
    "t TAB" '(comment-line :wk "Comment lines"))
 
 (xan/leader-keys
    "o" '(:ignore t :wk "Org")
    "o a" '(org-agenda :wk "Org agenda")
    "o e" '(org-export-dispatch :wk "Org export dispatch")
    "o i" '(org-toggle-item :wk "Org toggle item")
    "o t" '(org-todo :wk "Org todo")
    "o B" '(org-babel-tangle :wk "Org Babel Tangle")
    "o T" '(org-todo-list :wk "Org todo list"))

 (xan/leader-keys
    "o b" '(:ignore t :wk "Tables")
    "o b -" '(org-table-insert-hline :wk "Insert hline in table"))
 (xan/leader-keys
    "l" '(:ignore t :wk "Links")
    "l c" '(org-insert-link :wk "Org edit link"))

 (xan/leader-keys
    "o d" '(:ignore t :wk "Date/dateline")
    "o d t" '(org-time-stamp :wk "Time stamp"))
 
(general-create-definer xan/dired-file-ops
    :states '(normal)
    :keymaps 'dired-mode-map
    :prefix "y"
    :global-prefix "M-y"
    :wk "Dired file operations")
(xan/dired-file-ops
    "x" '(dirvish-move :wk "Move marked here")
    "c" '(dirvish-rsync :wk "Copy marked here")
    "l" '(dirvish-symlink :wk "Symlink marked here")
    "L" '(dirvish-relative-symlink :wk "Relative Symlink marked here")
    "h" '(dirvish-hardlink :wk "Hardlink marked here")
    "r" '(dired-do-rename :wk "Rename file")
    "k" '(dired-do-kill-lines :wk "Hide lines from view")
    "e" '(:ignore t :wk "Dired edit file")
    "e m" '(dired-do-chmod :wk "Chmod")
    "e o" '(dired-do-chown :wk "Chown")
    "e g" '(dired-do-chgrp :wk "Chgroup")
    "e t" '(dired-do-chgrp :wk "Ch-timestamp")
    "m" '(:ignore t :wk "Dired create")
    "m d" '(make-directory :wk "create Directory")
    "m f" '(make-empty-file :wk "Touch")
    "Y" '(dirvish-copy-file-path :wk "Copy path")
    "s" '(dirvish-ls-switches-menu :wk "Customize ls"
    "m m" '(xan-mount-menu :wk "Mount blockdevice")) 
    )


(general-auto-unbind-keys) ;; Automatically unbinds already bound keys if necessary. Prevents "Key sequence starts with a non-prefix key" errors
(general-create-definer xan/dired-open
    :states '(normal)
    :keymaps '(dired-mode-map)
    :prefix "o"
    ;;:global-prefix "M-o"
    :wk "Dired open files")
(xan/dired-open
    "p" '(dired-dragon :wk "NonPersistent Dragon")
    "m" '(xan-open-umpv :wk "Open mark in umpv"))

(general-create-definer xan/dired-compress
    :states '(normal)
    :keymaps '(dired-mode-map)
    :prefix "c"
    :global-prefix "M-c"
    :wk "Dired (un)compress files")
(xan/dired-compress
    "c" '(dired-do-compress :wk "(un)Compress here")
    "C" '(dired-do-compress-to :wk "(un)Compress to..."))


(general-create-definer xan/magit
    :states '(normal)
    :keymaps '(magit-mode-map)
    :prefix "g"
    :global-prefix "M-g"
    :wk "Magit git operations")
(xan/magit
    "i" '(:ignore t :wk "Gitignore")
    "i t" '(magit-gitignore-in-topdir :wk "Gitignore toplevel")
    "i s" '(magit-gitignore-on-system :wk "Gitignore on system")
    "i g" '(magit-gitignore-in-gitdir :wk "Gitignore in gitdir")
    "C" '(dired-do-compress-to :wk "(un)Compress to...")))

(require 'windmove)

;;;###autoload
(defun buf-move-up ()
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

(delete-selection-mode 1) ;; You can select text and delete by typing
(electric-indent-mode -1) ;; Turn of emacs wierd auto indenting
(electric-pair-mode 0) ;; Turn off auto parenthesis pairing

;; Prevents <> from auto pairing when electric-pair-mode is on. Otherwise org-tempo is broken when trying <s TAB for source blocks
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t) ;; Auto show changes if file changed
(global-display-line-numbers-mode 1) ;; display line numbers
(global-visual-line-mode t) ;; Truncated lines
(menu-bar-mode -1) ;; Disable menu bar
(scroll-bar-mode -1) ;; Disable scroll bar
(tool-bar-mode -1) ;; Disable tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block auto indent to 0 instead of 2

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(pixel-scroll-precision-mode)
(setq pixel-scroll-precision-use-momentum t)
(setq pixel-scroll-precision-large-scroll-height 60.0)

(setq scroll-step 5)

(setq mouse-wheel-progressive-speed nil)

(use-package dracula-theme :straight t)
;;(use-package catppuccin-theme)
;;(setq catppuccin-flavor 'latte)
;;(catppuccin-reload)
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
;;(load-theme 'EliaStellaria t)
(load-theme 'dracula t)
;;(add-hook 'emacs-startup-hook (lambda () (load-theme 'dracula)))

(use-package tldr
  :straight t)

(use-package rainbow-delimiters
  :straight t
  :hook ((emacs-lisp-mode .rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)
         (prog-mode . rainbow-delimiters-mode))
)

(add-to-list 'default-frame-alist '(alpha-background . 85))
(set-frame-parameter nil 'alpha-background 85)

(use-package rainbow-mode
  :straight t
  :hook org-mode prog-mode
  :diminish t)

(set-face-attribute 'default nil
                    :font "JetBrains Mono"
                    :height 160
                    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
                    :font "JetBrains Mono"
                    :height 160
                    :weight 'medium)
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

(add-to-list 'default-frame-alist '(font . "JetBrains Mono-16"))

;; uncomment it line spacing needs adjusting
;;(setq-default line-spacing 0.12)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(use-package ligature
  :straight t
  ;;:load-path "path-to-ligature-repo"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the 
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; And enable it for Org mode and its Source code blocks
  (ligature-set-ligatures 'org-mode '("--" "---" "==" "===" "!=" "!==" "=!=" "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!" "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>" "<<" ">>"
                                      "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####" "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$ $>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--" "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>" "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|" "<=|" "|=>" "|->" "<->" "<<~" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~" "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||" "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::=" ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???" ";;;" "labmda"))

  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))
  ;;(global-prettify-symbols-mode t) ;; Handling experssions like the word lambda

(use-package dashboard
  :straight t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs is an Elisp Interpreter!")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content nil)
  (setq dashboard-items '((recents . 5)
                          (agenda . 5)
                          (bookmarks . 3)
                          (projects . 3)
                          (registers .3)))
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))

(use-package projectile
  :straight t
  :config
  (projectile-mode 1))

(use-package sudo-edit
  :straight t
  :config
  (xan/leader-keys
    "f u" '(sudo-edit-find-file :wk "Sudo find file")
    "f U" '(sudo-edit :wk "Sudo edit this file")))

(use-package which-key
  :straight t
  :init
  (which-key-mode 1)
  :diminish t
  :config
  (setq
   which-key-side-window-location 'bottom
   which-key-sort-order #'which-key-key-order-alpha
   which-key-sort-uppercase-first nil
   which-key-add-column-padding 1
   which-key-max-display-columns nil
   which-key-min-display-lines 6
   which-key-side-window-slot -10
   which-key-side-window-max-height 0.25
   which-key-idle-delay 0.8
   which-key-max-description-length 25
   which-key-allow-imprecise-window-fit nil
   which-key-separator " -> "))

(use-package counsel
  :straight t
  :after ivy
  :config (counsel-mode)
  :diminish t)

(use-package ivy
  :straight t
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config 
  (ivy-mode)
  (setq ivy-initial-inputs-alist nil)
)

(use-package all-the-icons-ivy-rich
  :straight t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :straight t
  :after ivy
  :init (ivy-rich-mode 1) ;; gets descripitons in M-x
  :custom
  (ivy-virtual-appeviate 'full
			 ivy-rich-switch-buffer-align-virtual-buffer t
			 ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
			       'ivy-rich-switch-buffer-transformer))

(use-package all-the-icons
  :straight t
  :if (display-graphic-p))
(use-package all-the-icons-dired
  :straight t
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package toc-org
  :straight t
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable)
  :config (setq toc-org-max-depth 4))

(use-package org-auto-tangle :straight t
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
)

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets
  :straight t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)

(require 'org-tempo)

(use-package diminish :straight t)

(use-package magit :straight t)

(use-package ledger-mode :straight t)

(global-set-key [escape] 'keyboard-escape-quit)

(use-package lsp-mode
  :straight t
  :init
  ;;set prefix for lsp-command-keymap
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (python-mode . lsp-enable-which-key-integration)
         (dart-mode . lsp-enable-which-key-integration))
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode :straight t
  :config (setq lsp-ui-sideline-mode t)
  :hook ((prog-mode . lsp-ui-mode))
)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol :straight t)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list :straight t)

(use-package company
 :straight t
 :defer 2
 :diminish
 :custom
 (company-begin-commands '(self-insert-command))
 (company-idle-delay .1)
 (company-minimum-prefix-length 2)
 (company-show-numbers t)
 (company-tooltip-align-annotations 't)
 (global-company-mode t))

(use-package company-box
  :straight t
 :after company
 :diminish
 :hook (company-mode . company-box-mode))

(use-package pos-tip :straight t) ;; dependency of company-quickhelp
(use-package company-quickhelp :straight t) ;; shows documentation snippets in company

(use-package flycheck
  :straight t
 :defer t
 :diminish t
 :init (global-flycheck-mode))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t)
   (haskell .t)
   (C . t)
   )
)

(use-package irony 
  :straight t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)

  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  
)

(use-package company-qml :straight t)

(use-package qml-mode
  :straight t)

(use-package haskell-mode :straight t)
(use-package flymake-flycheck :straight t)
(use-package dante :straight t
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flymake-mode)
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
  (add-hook 'haskell-mode-hook 'dante-mode)
  (add-hook 'haskell-mode-hook
            (defun my-fix-hs-eldoc ()
              (setq eldoc-documentation-strategy #'eldoc-documentation-default)))
  :config
  (require 'flymake-flycheck))

;;(use-package js2-mode :straight t)
(use-package indium :straight t)

(use-package rustic :straight t)

(use-package json-mode :straight t)

(use-package yuck-mode :straight t)

(use-package pyimport :straight t)

(use-package lsp-pyright :straight t
 :hook (python-mode . (lambda ()
                       (require 'lsp-pyright)
                       (lsp))))

(use-package lsp-dart :straight t
  :config
  ;;(setq lsp-dart-sdk-dir "/home/xanadul/.flutter/bin/cache/dart-sdk")
  ;;(defvar xan-dart-hook nil "Hook for setting my dart settings, since setting them in use-package does not properly work")
  :hook (dart-mode . lsp)
)
(use-package dart-mode :straight t)

(use-package flutter :straight t
  :config 
  (setq flutter-sdk-path "/home/xanadul/.flutter")
  (setq lsp-dart-flutter-sdk-dir "/home/xanadul/.flutter")
  (setq lsp-dart-flutter-widget-guides nil)
  (setq lsp-dart-enable-sdk-formatter nil)
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024))
  (setq lsp-dart-line-length 320)
  (setq lsp-dart-closing-labels nil)
  (setq lsp-dart-outline nil)
  (setq lsp-dart-flutter-outline nil)
)

;(use-package parinfer-rust-mode
;  :hook emacs-lisp-mode
;  :init (setq parinfer-rust-auto-download t))

(use-package nix-mode :straight t
  :mode ("\\.nix\\'" "\\.nix.in\\'"))

;;(use-package nix-drv-mode :straight t
;;  :mode "\\.drv\\'")

;;(use-package nix-shell :straight t
;;  :commands (nix-shell-unpack nix-shell-configure nix-shell-build))

;;(use-package nix-repl :straight t
;;  :commands (nix-repl))

;;(use-package vterm :straight t
;; :config (setq shell-file-name "/usr/bin/zsh"
;;          vterm-max-scrollback 5000))

;; (use-package vterm-toggle :straight t
;;  :after vterm
;;  :config (setq vterm-toggle-fullscreen-p nil)
;;  (setq vterm-toggle-scope 'project)
;;  (add-to-list 'display-buffer-alist
;;   '((lambda (buffer-or-name _)
;;      (let (( buffer (get-buffer buffer-or-name)))
;;        (with-current-buffer buffer
;;           (or (equal major-mode 'vterm-mode)
;;             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
;;     (display-buffer-reuse-window display-buffer-at-bottom)
;;     (reusable-frames . visible)
;;     (window-height . 0.3))))

(setq dired-listing-switches "-gh --almost-all --group-directories-first") ;;sets ls arguments
(setq dired-dwim-target t);;If another dired window is open, guesses copy/rename location to be that window
(use-package dired-single :straight t ;;functions for not polluting Bufferlist when using dired
 :config
 (general-define-key
  :states 'normal
  :keymaps 'dired-mode-map
  "DEL" 'dired-up-directory ;;since dired-open does not work with dired-single-buffer
  "RET" 'dired-find-file
  [left] 'dired-up-directory
  [right] 'dired-find-file
  ))
  ;;"DEL" 'dired-single-up-directory ;;Equivalent of 'dired-up-directory
  ;;"RET" 'dired-single-buffer)) ;;Equivalent of 'dired-find-file

;;(setq wdired-allow-to-change-permissions advanced)

(load-file (expand-file-name "dired-dragon.el" user-emacs-directory))
(setq dired-dragon-location "/usr/bin/dragon-drop")

(use-package dired-hide-dotfiles :straight t
 :hook (dired-mode . dired-hide-dotfiles-mode) 
 :config
 (general-define-key
  :states 'normal
  :keymaps 'dired-mode-map
  "H" 'dired-hide-dotfiles-mode))

(use-package dired-open :straight t
 :config
 ;;(add-to-list 'dired-open-functions #'dired-open-xdg t) ;;Uses xdg to specify the program to use, however, it will use default FM for directories, which can interfere with dired.
 ;; --OR--
 (setq dired-open-extensions '(("png" . "nomacs") ;;Sets which extensions open in which programs
                               ("jpg" . "nomacs")
                               ("jpeg" . "nomacs")
                               ("pdf" . "okular")
                               ("xopp" . "xournalpp")
                               ("mkv" . "mpv")
                               ("mp3" . "mpv --force-window")
                               ("flac" . "mpv --force-window")
                               ("flv" . "mpv")
                               ("mp4" . "mpv"))))

(use-package dired-preview :straight t)

(use-package peep-dired :straight t)

(use-package dirvish :straight t
  :config
  (dirvish-override-dired-mode)
  (setq dirvish-preview-dispatchers '(image gif audio epub pdf archive)) ;; could also add video, but lets emacs freeze while ffmpegthumbnailer generates the preview
  (dirvish-define-preview exa (file)
    "Use `exa' to generate directory preview."
    :require ("exa") ; tell Dirvish to check if we have the executable
    (when (file-directory-p file) ; we only interest in directories here
      `(shell . ("exa" "-al" "--icons"
                 "--group-directories-first" ,file))))
  (add-to-list 'dirvish-preview-dispatchers 'exa)
  (setq dirvish-attributes
        '(file-time file-size collapse subtree-state vc-state git-msg))
  (setq dirvish-hide-details nil)
  (general-define-key
   :states 'normal
   :keymaps 'dired-mode-map
   "TAB" 'dirvish-subtree-toggle
   "t d" 'dired-hide-details-mode
   "t TAB" 'dirvish-layout-toggle)

  ;(push '("m"  "/run/media/xanadul/"  "Udisksctl mounts") dirvish-quick-access-entries)

)

(use-package hl-todo :straight t
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces 
        '(("TODO" warning bold)
          ("FIXME" error bold)
          ("BUG" error bold)
          ("HACK" font-lock-constant-face bold)
          ("REVIEW" font-lock-keyword-face bold)
          ("NOTE" success bold)
          ("DEPRECATED" font-lock-doc-face bold)
	  ("INSERT" font-lock-constant-face bold)
      ))
)

;;(use-package highlight-indent-guides :straight t
;;:hook prog-mode)

(use-package doom-modeline :straight t
  :init (doom-modeline-mode 1))

(use-package imenu-list :straight t
  :config (setq imenu-list-focus-after-activation t))

(use-package emms :straight t
:init
(require 'emms-setup)
(require 'emms-mpris)
(emms-all)
(emms-default-players)
(emms-mpris-enable)
:config
(setq emms-source-file-default-directory ews-music-directory)
(setq emms-browser-covers #'emms-browser-cache-thumbnail-async)
(setq emms-player-list '(emms-player-mpv))
)

(use-package eradio :straight t
  :init
  (setq eradio-player '("mpv" "--no-video" "--no-terminal" ))

  :config
  (setq eradio-channels '(
			  ("Listen.moe JPop vorbis" . "https://listen.moe/stream")
			  ("Listen.moe JPop opus" . "https://listen.moe/opus")
			  ("Listen.moe KPop opus" . "https://listen.moe/kpop/opus")
			  ))
)

(use-package pophint :straight t
  :config
  (setq pophint:popup-max-tips 1000))

(use-package simple-httpd :straight t)

(defun xan-open-umpv ()
  "Open marked files in uMPV."
  (interactive)
  ;; If nothing is marked, (dired-get-marked-files) returns the current lines filepath
  (dolist (element (dired-get-marked-files) value)
    (start-process "umpv" nil "umpv" element)
    (sleep-for 1)))

;; WIP, does not currently work
(defun xan-toggle-mark ()
  "Toggles marked line in Dired. If line is marked, unmark it. And vice versa"
  (interactive)
  (dolist (element (dired-get-marked-files) value)
    (if (eq element (dired-get-file-for-visit))
        (dired-unmark)
        (dired-mark))))

(defun xan-mount-menu ()
 "Prompt user to pick a blockdevice from a list. This will be put into udiskctl mount -b  to mount it in /run/media/xanadul/Label without root.
 TODO: Move output of lsblk to variable and immediatley kill buffer, so user cancelation doesn't leave an open buffer!"
 (interactive)
 (start-process "lsblk" (get-buffer-create "lsblk") "lsblk" "-o" "PATH,SIZE,MOUNTPOINT")
 (sleep-for 0.3)
 (let ((choices (split-string (tramp-get-buffer-string "lsblk") "\n")))
  (start-process "udisksctl" nil "udisksctl" "mount" "-b" (car (split-string (completing-read "Choose device:" choices) " "))))
 (kill-buffer "lsblk"))
  
(defun xan-recolor-sub ()
"Replaces the awful #FFFF00 color of subtitles in .srt files with pleasant #FFFFFF. Also note, .srt files are stupid and use #aabbggrr instead of #rrggbbaa" 
(interactive)
;;(query-replace "FFFF00" "FFFFFF")
;;(query-replace "00FFFF" "FFFFFF")
(query-replace 
 "Style: def2,Arial,58,&H0000FFFF,&H00FFFF00,&H00000008,&H80000008,0,0,0,0,100,100,0,0,1,5.8,0,2,50,50,30,0"
 "Style: def2,Arial,58,&H00FFFFFF,&H00FFFFFF,&H00000008,&H80000008,0,0,0,0,100,100,0,0,1,5.8,0,2,50,50,30,0")


)

(defun xan-dart-settings ()
    "Setting my dart settings, since setting them in use-package gets reverted on dart-mode activation"
     (interactive)
     (setq lsp-dart-flutter-widget-guides nil)
     (setq lsp-dart-enable-sdk-formatter nil)
     (setq gc-cons-threshold (* 100 1024 1024)
           read-process-output-max (* 1024 1024))
     (setq lsp-dart-line-length 320)
     (setq lsp-dart-closing-labels nil)
     (setq lsp-dart-outline nil)
     (setq lsp-dart-flutter-outline nil)
     (lsp-dart-flutter-widget-guides-mode)
     (run-hooks 'xan-dart-hook)
)

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

;;(add-to-list 'default-frame-alist '(fullscreen . maximized))
