(in-package #:nyxt-user)
(defvar *web-buffer-modes*
  '(:vi-normal-mode))

(define-nyxt-user-system-and-load nyxt-user/basic-config
  :components ("keybinds" "hsplit"))
               ;;"passwd" "status" "commands" "style" "unpdf" "objdump" "github"))

(defvar *my-search-engines*
  (list
   '("goog"     "https://google.com/search?q=~a" "https://google.com")
   '("python3"  "https://docs.python.org/3/search.html?q=~a" "https://docs.python.org/3")
   '("br"       "https://search.brave.com/search?q=~a" "https://search.brave.com")
   '("s"        "http://mikoto.ts:8380/search?q=~a&category_general=1&language=en-US&time_range=&safesearch=0&theme=simple" "http://mikoto.ts:3003")
   '("yt"       "https://www.youtube.com/results?search_query=~a")
   '("wiki"     "https://en.wikipedia.org/w/index.php?search=~a&title=Special%3ASearch&ns0=1"))
  "List of search engines.")
(define-configuration context-buffer
      "Go through the search engines above and make-search-engine out of them."
    ((search-engines
          (append
                (mapcar (lambda (engine) (apply 'make-search-engine engine))
                        *my-search-engines*)
                %slot-default%))))

(define-configuration :hint-mode
  "Set up Colmak-DH-Xan home row as the hint keys."
  ((hints-alphabet "TSNEGMPLFUWZ")))

(define-configuration :buffer
    "Smooth scrolling in every buffer"
    ((smooth-scrolling t))
    ((default-modes "dark-mode")))

(define-configuration :web-buffer
  "Basic modes setup for web-buffer."
  ((default-modes `(,@*web-buffer-modes* ,@%slot-value%))))

(define-configuration :browser
 "Set new buffer URL (a.k.a. start page, new tab page)."
 ((default-new-buffer-url "https://search.brave.com/")))

;; Create a function to launch mpv with given url
(defun mpv (url)
  "MPV launches with given url using the fast profile."
  (uiop:run-program (list "mpv" url)))

(define-panel-command hsplit-internal (&key (url (quri:render-uri (url (current-buffer)))))
    (panel "*Duplicate panel*" :right)
  "Duplicate the current buffer URL in the panel buffer on the right.

A poor man's hsplit :)"
  (setf (ffi-width panel) 550)
  (run-thread "URL loader"
    (sleep 0.3)
    (buffer-load (quri:uri url) :buffer panel))
  "")

(define-command-global close-all-panels ()
  "Close all the panel buffers there are."
  (alexandria:when-let ((panels (nyxt/renderer/gtk::panel-buffers-right (current-window))))
    (delete-panel-buffer :window (current-window) :panels panels))
  (alexandria:when-let ((panels (nyxt/renderer/gtk::panel-buffers-left (current-window))))
    (delete-panel-buffer :window (current-window) :panels panels)))

(define-command-global hsplit ()
  "Based on `hsplit-internal' above."
  (if (nyxt/renderer/gtk::panel-buffers-right (current-window))
      (delete-all-panel-buffers (current-window))
      (hsplit-internal)))

(define-configuration :document-mode
  "Add basic keybindings."
  ((keyscheme-map
    (keymaps:define-keyscheme-map
     "custom" (list :import %slot-value%)
     ;; If you want to have VI bindings overriden, just use
     ;; `scheme:vi-normal' or `scheme:vi-insert' instead of
     ;; `scheme:emacs'.
     nyxt/keyscheme:emacs
     (list "C-c p" 'copy-password
           "C-c y" 'autofill
           "C-f" :history-forwards-maybe-query
           "C-i" :input-edit-mode
           "M-:" 'eval-expression
           "C-s" :search-buffer
           "C-x 3" 'hsplit
           "C-x 1" 'close-all-panels
           "C-'"  (lambda-command insert-left-angle-quote ()
                    (ffi-buffer-paste (current-buffer) "«"))
           "C-M-'" (lambda-command insert-left-angle-quote ()
                     (ffi-buffer-paste (current-buffer) "»"))
           "C-M-hyphen" (lambda-command insert-left-angle-quote ()
                          (ffi-buffer-paste (current-buffer) "—"))
           "C-M-_" (lambda-command insert-left-angle-quote ()
                     (ffi-buffer-paste (current-buffer) "–"))
           "C-E" (lambda-command small-e-with-acute ()
                   (ffi-buffer-paste (current-buffer) "é"))
           "C-A" (lambda-command small-a-with-acute ()
                   (ffi-buffer-paste (current-buffer) "á"))
           "C-I" (lambda-command small-i-diaeresis ()
                   (ffi-buffer-paste (current-buffer) "ï"))
           "C-h hyphen" 'clcs-lookup)

nyxt/keyscheme:vi-normal
(list "space space" 'execute-command
      "space b i" 'list-buffers
      "space b b" 'switch-buffer
      "space b C" 'delete-buffer
      "space b c" 'delete-current-buffer
      "space b u" 'reopen-last-buffer
      "space b U" 'reopen-buffer
      "space b h" 'list-history

      "space ." 'set-url
      "space n" 'set-url-new-buffer

      "space t h" 'headings-panel

      "down" 'scroll-down
      "shift-down" 'scroll-page-down
      "up" 'scroll-up
      "shift-up" 'scroll-page-up
      "f"          'follow-hint
      "F"          'follow-hint-new-buffer)))))
