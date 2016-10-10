;; -*- coding: utf-8 -*-

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *macbook-pro-support-enabled* t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
(setq *win32* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *linux-x* (and window-system *linux*) )
(setq *xemacs* (featurep 'xemacs) )
(setq *emacs23* (and (not *xemacs*) (or (>= emacs-major-version 23))) )
(setq *emacs24* (and (not *xemacs*) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

;;----------------------------------------------------------------------------
;; Less GC, more memory
;;----------------------------------------------------------------------------
;; By default Emacs will initiate GC every 0.76 MB allocated
;; (gc-cons-threshold == 800000).
;; we increase this to 512MB
;; @see http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
(setq-default gc-cons-threshold (* 1024 1024 512)
              gc-cons-percentage 0.5)

(require 'init-modeline)
(require 'cl-lib)
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el

;; my personal setup, other major-mode specific setup need it.
;; It's dependent on init-site-lisp.el
(if (file-exists-p "~/.custom.el") (load-file "~/.custom.el"))

;; win32 auto configuration, assuming that cygwin is installed at "c:/cygwin"
;; (condition-case nil
;;     (when *win32*
;;       ;; (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
;;       (setq cygwin-mount-cygwin-bin-directory "c:/cygwin64/bin")
;;       (require 'setup-cygwin)
;;       ;; better to set HOME env in GUI
;;       ;; (setenv "HOME" "c:/cygwin/home/someuser")
;;       )
;;   (error
;;    (message "setup-cygwin failed, continue anyway")
;;    ))

(require 'idle-require)
(require 'init-elpa)
(require 'init-exec-path) ;; Set up $PATH
(require 'init-frame-hooks)
;; any file use flyspell should be initialized after init-spelling.el
;; actually, I don't know which major-mode use flyspell.
(require 'init-spelling)
(require 'init-xterm)
(require 'init-gui-frames)
(require 'init-ido)
(require 'init-dired)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flymake)
(require 'init-smex)
(if *emacs24* (require 'init-helm))
(require 'init-hippie-expand)
(require 'init-windows)
(require 'init-sessions)
(require 'init-git)
(require 'init-crontab)
(require 'init-markdown)
(require 'init-erlang)
(require 'init-javascript)
(when *emacs24*
  (require 'init-org)
  (require 'init-org-mime))
(require 'init-css)
(require 'init-python-mode)
(require 'init-haskell)
(require 'init-ruby-mode)
(require 'init-lisp)
(require 'init-elisp)
(if *emacs24* (require 'init-yasnippet))
;; Use bookmark instead
(require 'init-zencoding-mode)
(require 'init-cc-mode)
(require 'init-gud)
(require 'init-linum-mode)
;; (require 'init-gist)
(require 'init-moz)
(require 'init-gtags)
;; use evil mode (vi key binding)
;; (require 'init-evil)
(require 'init-sh)
(require 'init-ctags)
(require 'init-ace-jump-mode)
(require 'init-bbdb)
(require 'init-gnus)
(require 'init-lua-mode)
(require 'init-workgroups2)
(require 'init-term-mode)
(require 'init-web-mode)
(require 'init-slime)
(require 'init-clipboard)
(when *emacs24* (require 'init-company))
(require 'init-chinese-pyim) ;; cannot be idle-required
;; need statistics of keyfreq asap
(require 'init-keyfreq)

;; projectile costs 7% startup time

;; misc has some crucial tools I need immediately
(require 'init-misc)
(require 'init-color-theme)
(require 'init-emacs-w3m)

;; {{ idle require other stuff
(setq idle-require-idle-delay 3)
(setq idle-require-symbols '(init-misc-lazy
                             init-which-func
                             init-fonts
                             init-sr-speedbar
                             init-hs-minor-mode
                             init-stripe-buffer
                             init-textile
                             init-csv
                             init-writting
                             init-elnode
                             init-doxygen
                             init-pomodoro
                             init-emacspeak
                             init-artbollocks-mode
                             init-semantic))
(idle-require-mode 1) ;; starts loading
;; }}

(when (require 'time-date nil t)
   (message "Emacs startup time: %d seconds."
    (time-to-seconds (time-since emacs-load-start-time))))

;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cfs--current-profile "profile1" t)
 '(cfs--profiles-steps (quote (("profile1" . 5))) t)
 '(coffee-tab-width 2)
 '(git-gutter:handled-backends (quote (svn hg git)))
 '(package-selected-packages
   (quote
    (## jade-mode youdao-dictionary yasnippet yaml-mode yagist writeroom-mode wgrep w3m unfill textile-mode tagedit switch-window swiper string-edit sr-speedbar session scss-mode scratch sass-mode rvm robe rinari regex-tool rainbow-delimiters quack pomodoro pointback paredit page-break-lines mwe-log-commands multiple-cursors multi-term move-text minitest mic-paren markdown-mode magit lua-mode link less-css-mode legalese json-mode js2-mode idomenu ibuffer-vc htmlize hl-sexp haskell-mode guide-key gitignore-mode gitconfig-mode git-timemachine git-gutter ggtags fringe-helper flyspell-lazy flymake-sass flymake-ruby flymake-python-pyflakes flymake-lua flymake-jslint flymake-css flymake-coffee flx-ido expand-region exec-path-from-shell erlang emmet-mode elnode dsvn dropdown-list dired-details dired+ diminish dictionary csharp-mode crontab-mode cpputils-cmake connection company-c-headers company-anaconda color-theme coffee-mode cmake-mode buffer-move bookmark+ bbdb auto-compile ag ace-jump-mode)))
 '(safe-local-variable-values
   (quote
    ((encoding . utf-8)
     (ruby-compilation-executable . "ruby")
     (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9")
     (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby")
     (lentic-init . lentic-orgel-org-init))))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
;;; Local Variables:
;;; no-byte-compile: t
;;; End:
(put 'erase-buffer 'disabled nil)

;; This gives you a tab of 2 spaces
(custom-set-variables '(coffee-tab-width 2))

;;;;;;;;;;;;;;;;
;; add github load-path
;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "~/.emacs.d/github"
;;              (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/github")
(progn (cd "~/.emacs.d/github")
       (normal-top-level-add-subdirs-to-load-path))

;(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized/")
(require 'color-theme-solarized)
(color-theme-solarized-dark)

;(add-to-list 'load-path "~/.emacs.d/undo-tree/")
(require 'undo-tree)
(global-undo-tree-mode)

;;ruby-electric-mode
;; (require 'ruby-electric)
;; (eval-after-load "ruby-mode"
;;   '(add-hook 'ruby-mode-hook 'ruby-electric-mode))


;;;ParEdit mode
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

;;;;;;;;;;;;
;; Scheme
;;;;;;;;;;;;

(require 'cmuscheme)
(setq scheme-program-name "racket")         ;; 如果用 Petite 就改成 "petite"
;; (setq scheme-program-name "petite")         ;; 如果用 Petite 就改成 "petite"


;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))


(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (find "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))


(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))


(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "C-x C-e") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))

;; scheme parentheses face
(require 'paren-face)
(set-face-foreground 'parenthesis "DimGray")

(setq semantic-idle-scheduler-idle-time 432000)

;; 设置字体
;; (set-fontset-font "fontset-default" 'han '("STHeiti"))
;; (set-default-font "Monaco 12")
;;  (set-fontset-font
;;    (frame-parameter nil 'font)
;;    'han
;;    (font-spec :family"WenQuanYi Micro Hei Mono":size 12))
(require 'chinese-fonts-setup)


;; about beancount
(require 'beancount)
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))
(add-to-list 'auto-mode-alist '("\\.bean\\'" . beancount-mode))
(setq css-indent-offset 2)
