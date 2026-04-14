;; ------------------------------------------------------------------------
;;                                Init Load
;; ------------------------------------------------------------------------

;; Suppress menu bar / tool bar / scroll bar at frame-creation time.
;; On Linux (GTK) builds the initial frame can be created before
;; `menu-bar-mode -1' runs, so setting these in `default-frame-alist'
;; early ensures the frame never has a menu bar to begin with.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Use native compilation for better performance
(when (fboundp 'native-comp-available-p)
  (setq native-comp-speed 2
        package-native-compile t))

;; Package management (built-in package.el + MELPA)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; use-package (built-in since Emacs 29, install from MELPA for Emacs 28)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Helper: install package from GitHub (works on Emacs 28+)
(defun my/ensure-package-from-github (package url)
  "Install PACKAGE from GitHub URL if not already installed.
Uses package-vc-install on Emacs 29+, git clone on Emacs 28."
  (unless (package-installed-p package)
    (if (fboundp 'package-vc-install)
        (package-vc-install url)
      (let ((dir (expand-file-name (symbol-name package)
                                   (expand-file-name "github-packages"
                                                     user-emacs-directory))))
        (unless (file-directory-p dir)
          (make-directory (file-name-directory dir) t)
          (call-process "git" nil nil nil "clone" url dir))
        (add-to-list 'load-path dir)))))

;; Helper: install a package from GitHub purely via `git clone` and add its
;; directory to `load-path'. This is a safer alternative for old packages
;; whose headers use RCS-style version strings (e.g. "$Id: foo.el,v 1.6 ...")
;; which `package-vc-install' cannot parse and which therefore cause
;; `package-installed-p' to keep returning nil, triggering reinstall prompts
;; on every Emacs startup.
(defun my/ensure-github-loadpath (package url)
  "Ensure PACKAGE from GitHub URL is available via `load-path'.
Clones URL into <user-emacs-directory>/github-packages/PACKAGE with
plain git, bypassing package.el entirely. If the package's main
library can already be located via `locate-library', nothing is
cloned and the function is a no-op."
  (unless (locate-library (symbol-name package))
    (let* ((base-dir (expand-file-name "github-packages" user-emacs-directory))
           (dir (expand-file-name (symbol-name package) base-dir)))
      (unless (file-directory-p base-dir)
        (make-directory base-dir t))
      (unless (file-directory-p dir)
        (message "Cloning %s from %s..." package url)
        (call-process "git" nil nil nil "clone" "--depth" "1" url dir))
      (add-to-list 'load-path dir))))

;; Emacs lisp utility functions
(use-package dash)

(use-package paredit)
(use-package subword :ensure nil)
(use-package eglot)
(defun hook-lisp (mode-name)
  "Add lisp utility modes"
  (dolist (hook-mode-name '(enable-paredit-mode
                            subword-mode
                            eglot-ensure))
    (add-hook mode-name hook-mode-name)))

;; Feeling good selection range
(use-package expand-region
  :bind
  (("C-@" . 'er/expand-region)
   ("C-M-@" . 'er/contract-region)))

;; Disable bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; ------------------------------------------------------------------------
;;                               OS Dependent
;; ------------------------------------------------------------------------

(defun is-linux ()
  (eq system-type 'gnu/linux))

(defun is-windows ()
  (eq system-type 'windows-nt))

(defun is-mac ()
  (eq system-type 'darwin))

(when (is-linux)
  (setq shell-file-name "/usr/bin/fish")
  (use-package exec-path-from-shell
    :init (exec-path-from-shell-initialize)))

(when (is-mac)
  (use-package ucs-normalize :ensure nil)
  (set-file-name-coding-system 'utf-8-hfs))

(when (is-windows)
  (scroll-bar-mode -1)
  (toggle-frame-fullscreen))

;; ------------------------------------------------------------------------
;;                               Doom Theme
;; ------------------------------------------------------------------------

(use-package doom-themes
  :config
  (load-theme 'doom-monokai-pro t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (line-number-mode 0)
  (column-number-mode 0)
  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info persp-name lsp github debug minor-modes input-method major-mode process vcs)))

;; ------------------------------------------------------------------------
;;                                Company
;; ------------------------------------------------------------------------

;; Common setting
(use-package company
  :init
  (global-company-mode)
  (setq company-global-modes
        '(not slime-mode slime-repl-mode lisp-mode))
  :config
  (setq company-auto-expand t
        company-dabbrev-downcase nil
        company-idle-delay 0
        company-minimum-prefix-length 2
        company-selection-wrap-around t
        company-transformers '(company-sort-by-backend-importance)
        completion-ignore-case t)

  (defun company--insert-candidate2 (candidate)
    (when (> (length candidate) 0)
      (setq candidate (substring-no-properties candidate))
      (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
          (insert (company-strip-prefix candidate))
        (if (equal company-prefix candidate)
            (company-select-next)
          (delete-region (- (point) (length company-prefix)) (point))
          (insert candidate)))))
  (defun company-complete-common2 ()
    (interactive)
    (when (company-manual-begin)
      (if (and (not (cdr company-candidates))
               (equal company-common (car company-candidates)))
          (company-complete-selection)
        (company--insert-candidate2 company-common))))
  (define-key company-active-map [tab] #'company-complete-common2)
  (define-key company-active-map [backtab] #'company-select-previous))

;; ------------------------------------------------------------------------
;;                              Common Lisp
;; ------------------------------------------------------------------------

;; SLIME settings
(use-package slime
  :config
  (slime-setup '(slime-repl slime-fancy slime-banner))
  (setq inferior-lisp-program "sbcl"
        slime-net-coding-system 'utf-8-unix)
  (slime-autodoc-mode)

  (use-package popwin
    :config
    (setq special-display-function 'popwin:special-display-popup-window)
    (push '("*slime-apropos*") popwin:special-display-config)
    (push '("*slime-compilation*" :noselect t) popwin:special-display-config)
    (push '("*slime-description*") popwin:special-display-config)
    (push '("*slime-macroexpansion*") popwin:special-display-config)
    (push '("*slime-xref*") popwin:special-display-config)
    (push '(sldb-mode :stick t) popwin:special-display-config)
    (push '(slime-connection-list-mode) popwin:special-display-config)
    (push '(slime-repl-mode) popwin:special-display-config))

  (use-package ac-slime
    :config
    (add-hook 'slime-mode-hook #'auto-complete-mode)
    (add-hook 'slime-mode-hook #'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook #'auto-complete-mode)
    (add-hook 'slime-repl-mode-hook #'set-up-slime-ac)
    (add-hook 'lisp-mode-hook #'auto-complete-mode)
    (add-hook 'lisp-mode-hook #'set-up-slime-ac))

  ;; Other hook add
  (hook-lisp 'lisp-mode-hook)
  (hook-lisp 'slime-mode-hook)
  (hook-lisp 'slime-repl-mode-hook))

;; ------------------------------------------------------------------------
;;                                Clojure
;; ------------------------------------------------------------------------

(use-package clojure-mode
  :config
  (add-hook 'clojure-mode #'company-mode)
  (hook-lisp 'clojure-mode-hook))

(use-package cider
  :init
  (add-hook 'cider-mode-hook #'company-mode)
  (hook-lisp 'cider-mode-hook)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (hook-lisp 'cider-repl-mode-hook)
  :config (setf cider-repl-display-help-banner nil))

(use-package clj-refactor
  :init (add-hook 'cider-mode-hook #'clj-refactor-mode))

;; ------------------------------------------------------------------------
;;                                 Java
;; ------------------------------------------------------------------------

(use-package lsp-java
  :config
  (add-hook 'java-mode-hook #'lsp))

;; ------------------------------------------------------------------------
;;                              TypeScript
;; ------------------------------------------------------------------------

(use-package typescript-mode)

;; ------------------------------------------------------------------------
;;                              JavaScript
;; ------------------------------------------------------------------------

(when (file-directory-p "~/usr/local/bin/")
  (add-to-list 'exec-path (expand-file-name "~/usr/local/bin/")))

(use-package skewer-mode)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (js-mode . lsp-deferred))

;; ------------------------------------------------------------------------
;;                                  Go
;; ------------------------------------------------------------------------

(when (file-directory-p "~/go/bin/")
  (add-to-list 'exec-path (expand-file-name "~/go/bin/")))

(use-package go-mode
  :config
  ;; gofmt before save
  (add-hook 'before-save-hook #'gofmt-before-save nil t)

  ;; key bindings
  (add-hook 'go-mode-hook
            (lambda ()
              (local-set-key (kbd "M-.") #'godef-jump)))

  ;; company-mode setup
  (add-hook 'go-mode-hook
            (lambda ()
              (setq-local company-backends '(company-go))
              (company-mode 1)))

  ;; eldoc
  (add-hook 'go-mode-hook #'go-eldoc-setup))

(use-package company-go
  :init
  (add-hook 'go-mode-hook #'company-go-init))

;; ------------------------------------------------------------------------
;;                        Other Programming Language
;; ------------------------------------------------------------------------

(use-package quickrun)

;; ------------------------------------------------------------------------
;;                           EWW (Web Browser)
;; ------------------------------------------------------------------------

(use-package eww
  :ensure nil
  :config

  ;; Disable background and text color
  (defvar eww-disable-colorize t)
  (defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
    (unless eww-disable-colorize
      (funcall orig start end fg)))
  (advice-add 'shr-colorize-region :around #'shr-colorize-region--disable)
  (advice-add 'eww-colorize-region :around #'shr-colorize-region--disable)

  ;; Set default browser (EWW)
  (setq browse-url-browser-function 'eww-browse-url
        ;; disable header
        eww-header-line-format nil))

;; ------------------------------------------------------------------------
;;                          Syntax Check
;; ------------------------------------------------------------------------

(my/ensure-package-from-github 'highlight-cl "https://github.com/emacsmirror/highlight-cl")
(use-package highlight-cl
  :ensure nil)

;; Highlight symbol setting
(use-package highlight-symbol
  :config
  (global-set-key (kbd "<C-f3>") #'highlight-symbol-at-point)
  (global-set-key (kbd "<f3>") #'highlight-symbol-next)
  (global-set-key (kbd "<S-f3>") #'highlight-symbol-prev)
  (global-set-key (kbd "<M-f3>") #'highlight-symbol-query-replace)
  (setq highlight-symbol-idle-delay 0)
  (add-hook 'prog-mode-hook #'highlight-symbol-mode)
  (add-hook 'prog-mode-hook #'highlight-symbol-nav-mode)
  :bind (("M-s M-r" . highlight-symbol-query-replace)))

;; Rainbow delimiters setting
(use-package color :ensure nil)
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (defun rainbow-delimiters-using-stronger-colors ()
    (interactive)
    (dotimes (index rainbow-delimiters-max-face-count)
      (let* ((face (intern (format "rainbow-delimiters-depth-%d-face" (1+ index))))
             (foreground (face-foreground face)))
        (set-face-foreground face (color-saturate-name foreground 30)))))
  (add-hook 'emacs-startup-hook #'rainbow-delimiters-using-stronger-colors))

;; ------------------------------------------------------------------------
;;                              History
;; ------------------------------------------------------------------------

(my/ensure-github-loadpath 'redo+ "https://github.com/emacsmirror/redo-plus")
(use-package redo+
  :ensure nil
  :bind (("C-?" . redo)))

;; All indent
(my/ensure-github-loadpath 'point-undo "https://github.com/emacsmirror/point-undo")
(use-package point-undo
  :ensure nil
  :config
  (defun all-indent ()
    (interactive)
    (mark-whole-buffer)
    (indent-region (region-beginning) (region-end))
    (point-undo))
  :bind (("C-x C-]" . all-indent)))

;; Redo
(setq undo-no-redo t)

;; ------------------------------------------------------------------------
;;                        Emacs Environ Setting
;; ------------------------------------------------------------------------

;; Environment (UTF-8 Japanese)
(prefer-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-language-environment "Japanese")
(set-locale-environment nil)
(set-terminal-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)

;; Multi cursor setting
(use-package multiple-cursors)
(use-package smartrep
  :config
  (declare-function smartrep-define-key "smartrep")
  (global-unset-key (kbd "C-t"))
  (smartrep-define-key global-map "C-t"
    '(("C-t"      . mc/mark-next-like-this)
      ("n"        . mc/mark-next-like-this)
      ("p"        . mc/mark-previous-like-this)
      ("m"        . mc/mark-more-like-this-extended)
      ("u"        . mc/unmark-next-like-this)
      ("U"        . mc/unmark-previous-like-this)
      ("s"        . mc/skip-to-next-like-this)
      ("S"        . mc/skip-to-previous-like-this)
      ("*"        . mc/mark-all-like-this)
      ("d"        . mc/mark-all-like-this-dwim)
      ("i"        . mc/insert-numbers)
      ("o"        . mc/sort-regions)
      ("O"        . mc/reverse-regions)))
  :bind
  (("C-M-c" . mc/edit-lines)
   ("C-M-r" . mc/mark-all-in-region)))

;; Vim mode
(use-package evil
  :config
  (setq evil-default-state 'emacs)
  (evil-mode 1))

;; Nyan mode !!
(use-package nyan-mode
  :config
  (nyan-mode)
  (nyan-start-animation))

;; Display EOL
(setq eol-mnemonic-dos "(CRLF)"
      eol-mnemonic-mac "(CR)"
      eol-mnemonic-unix "(LF)")

;; Jump cursor
(use-package ace-jump-mode
  :bind (("C-c SPC" . ace-jump-mode)))

;; Case-insensitive
(setq completion-ignore-case t
      read-file-name-completion-ignore-case t)

;; Completion setting (Helm)
(use-package helm
  :config
  (helm-mode 1)
  :bind
  (("M-y"   . helm-show-kill-ring)
   ("C-c i" . helm-imenu)
   ("C-x b" . helm-buffers-list)
   ("C-h"   . delete-backward-char)
   ("TAB"   . helm-execute-persistent-action)))

;; Completion setting (fuzzy)
(use-package fuzzy)

;; Find file or directory
(use-package deadgrep
  :bind (("C-c s" . deadgrep)))

;; Search file name in project
(use-package find-file-in-project
  :config (global-set-key (kbd "s-I") #'find-file-in-project))

;; Add Emacs Lisp utility modes
(hook-lisp 'emacs-lisp-mode-hook)

;; Key bind hint
(use-package which-key
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

;; ------------------------------------------------------------------------
;;                           Other Setting
;; ------------------------------------------------------------------------

;; View git diff
(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(my/ensure-package-from-github 'git-complete "https://github.com/zk-phi/git-complete")
(use-package git-complete
  :ensure nil)

(use-package fish-mode
  :mode "\\.fish\\'")

;; Not create backup files
(setq auto-save-default nil
      auto-save-list-file-name nil
      auto-save-list-file-prefix nil
      backup-inhibited t
      create-lockfiles nil
      make-backup-files nil
      version-control nil)

;; If file head line is #!, add execution authority
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

;; Disable beep sound
(setq visible-bell t
      ring-bell-function 'ignore)

;; Highlight yank text
(defun highlight-yank (start end)
  (let ((ol (make-overlay start end)))
    (overlay-put ol 'face 'highlight)
    (run-with-timer 0.5 nil #'delete-overlay ol)))

(advice-add 'yank :after
            (lambda (&rest _)
              (highlight-yank (mark t) (point))))
(advice-add 'yank-pop :after
            (lambda (&rest _)
              (when (eq last-command 'yank)
                (highlight-yank (mark t) (point)))))

;; Defined in external file (package-install-selected-packages)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Highlight corresponding parenthesis
(use-package paren
  :ensure nil
  :custom
  (show-paren-style 'mixed)
  (show-paren-when-point-inside-paren t)
  (show-paren-when-point-in-periphery t)
  :config (show-paren-mode 1))

;; Cursor beacon
(use-package beacon
  :custom (beacon-color "blue")
  :config (beacon-mode 1))

(use-package powershell)

(use-package markdown-mode)

;; Truncate setting (set Disable)
(setq truncate-lines nil
      truncate-partial-width-windows nil)

(add-hook 'before-save-hook #'all-indent) ; Auto indent when before save
(add-hook 'before-save-hook #'delete-trailing-whitespace) ; Remove tail space when before save
(add-hook 'comint-output-filter-functions #'comint-watch-for-password-prompt) ; Hide password
(delete 'mode-line-modes mode-line-format) ; Hide mode name
(defalias 'yes-or-no-p 'y-or-n-p) ; "yes or no" -> "y or n"
(global-auto-revert-mode 1) ; Auto reload buffer
(global-set-key (kbd "C-x C-b") #'bs-show) ; Better display buffer list
(global-set-key (kbd "<f5>") #'redraw-display)
(global-set-key (kbd "<f8>") #'neotree-toggle) ; Open Directory tree
(icomplete-mode 1) ; Always display completion candidate
(set-frame-parameter nil 'alpha 85) ; Transparency
(setq delete-auto-save-files t ; Delete auto save file when exiting
      inhibit-startup-echo-area-message -1 ; Disable echo area
      inhibit-startup-message t ; Disable start-up message
      kill-whole-line t) ; C-k delete line
(setq-default indent-tabs-mode nil ; Disable tab
              tab-width 2) ; Tab is 2 whitespace
(size-indication-mode t) ; Display filesize

(custom-set-variables
 '(package-vc-selected-packages
   '((helm-ag :vc-backend Git :url "https://github.com/emacsorphanage/helm-ag"))))
(custom-set-faces )
