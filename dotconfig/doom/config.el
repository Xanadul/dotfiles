;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Xanadul"
      user-mail-address "Xanadul@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq dired-listing-switches '"-ahl -v --group-directories-first --time-style=+%x_%X")
(setq doom-font (font-spec :family "JetBrains Mono" :size 25 :weight 'regular))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
(use-package! weblorg)

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;(setq user-mail-address "sputnik199@gmx.de"
;;      user-full-name "Sandro774"
;;      mu4e-get-mail-command "mbsync -c ~/.config/mu4e/mbsyncrc -a")

;;(use-package! eaf
;;  :load-path "~/.elisp/emacs-application-framework"
;;  :init
;;  :custom
;;  (eaf-browser-continue-where-left-off t)
;;  (eaf-browser-enable-adblocker t)
;;  (browse-url-browser-function 'eaf-open-browser) ;; Make EAF Browser my default browser
;;  :config
;;  (defalias 'browse-web #'eaf-open-browser)
;;
;;  ;;(require 'eaf-file-manager)
;;  ;;(require 'eaf-music-player)
;;  ;;(require 'eaf-image-viewer)
;;  ;;(require 'eaf-camera)
;;  ;;(require 'eaf-demo)
;;  ;;(require 'eaf-airshare)
;;  ;;(require 'eaf-terminal)
;;  ;;(require 'eaf-markdown-previewer)
;;  ;;(require 'eaf-video-player)
;;  ;;(require 'eaf-vue-demo)
;;  ;;(require 'eaf-file-sender)
;;  ;;(require 'eaf-pdf-viewer)
;;  ;;(require 'eaf-mindmap)
;;  ;;(require 'eaf-netease-cloud-music)
;;  ;;(require 'eaf-jupyter)
;;  ;;(require 'eaf-org-previewer)
;;  ;;(require 'eaf-system-monitor)
;;  ;;(require 'eaf-rss-reader)
;;  ;;(require 'eaf-file-browser)
;;  (require 'eaf-browser)
;;  ;;(require 'eaf-org)
;;  ;;(require 'eaf-mail)
;;  ;;(require 'eaf-git)
;;  (when (display-graphic-p)
;;    (require 'eaf-all-the-icons)
;;
;;  (require 'eaf-evil)
;;  (define-key key-translation-map (kbd "SPC")
;;    (lambda (prompt)
;;      (if (derived-mode-p 'eaf-mode)
;;          (pcase eaf--buffer-app-name
;;            ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
;;                           (kbd "SPC")
;;                         (kbd eaf-evil-leader-key)
;;            ("pdf-viewer" (kbd eaf-evil-leader-key))
;;            ("image-viewer" (kbd eaf-evil-leader-key))
;;            (_  (kbd "SPC"))
;;        (kbd "SPC"))

(setq imenu-list-focus-after-activation t)
;;(map! :leader
;;      (:prefix ("s" . "Search")
;;        :desc "Menu to jump to places in buffer" "i" #'counsel-imenu)
(map! :leader
        (:prefix ("t" . "Toggle")))

(setq display-line-numbers-type t)
(map! :leader
      :desc "Comment or uncomment lines"      "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
        :desc "Toggle line numbers"            "l"  #'doom/toggle-line-numbers
        :desc "Toggle line highlight in frame" "h"  #'hl-line-mode
        :desc "Toggle line highlight globally" "H"  #'global-hl-line-mode
        :desc "Toggle imenu shown in a sidebar" "i" #'imenu-list-smart-toggle
        :desc "Toggle truncate lines"          "t"  #'toggle-truncate-lines))
