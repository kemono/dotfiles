;; ------------------------------------------------------------------------
;;                                Init Load
;; ------------------------------------------------------------------------

(setq package-native-compile t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Emacs lisp utility functions
(use-package dash)

(use-package paredit)
(use-package subword)
(use-package eldoc)
(defun hook-lisp (mode-name)
  "Add lisp utility modes"
  (-map (lambda (hook-mode-name)
          (add-hook mode-name hook-mode-name))
        '(enable-paredit-mode
          subword-mode
          eldoc-mode)))

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
  (use-package ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs))

(when (is-windows)
  (scroll-bar-mode -1)
  (toggle-frame-fullscreen))

;; ------------------------------------------------------------------------
;;                               Doom Theme
;; ------------------------------------------------------------------------

(use-package doom-themes
  :config
  (load-theme 'doom-Iosvkem t)
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
  (if (is-linux)
      (doom-modeline-def-modeline 'main
        '(bar workspace-number window-number evil-state god-state ryo-modal xah-fly-keys matches buffer-info remote-host buffer-position parrot selection-info)
        '(misc-info persp-name lsp github debug minor-modes input-method major-mode process vcs checker))
    (doom-modeline-def-modeline 'main
      '(bar window-number matches buffer-info remote-host buffer-position parrot selection-info)
      '(misc-info persp-name lsp github debug minor-modes input-method major-mode process vcs checker))))

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
  (setq company-auto-expand t)
  (setq company-dabbrev-downcase nil)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-backend-importance))
  (setq completion-ignore-case t)

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
  (define-key company-active-map [tab] 'company-complete-common2)
  (define-key company-active-map [backtab] 'company-select-previous))

;; ------------------------------------------------------------------------
;;                              Common Lisp
;; ------------------------------------------------------------------------

;; SLIME settings
(use-package slime
  :config
  (slime-setup '(slime-repl slime-fancy slime-banner))
  (setq inferior-lisp-program "sbcl")
  (setq slime-net-coding-system 'utf-8-unix)
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
    (add-hook 'slime-mode-hook 'auto-complete-mode)
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'auto-complete-mode)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (add-hook 'lisp-mode-hook 'auto-complete-mode)
    (add-hook 'lisp-mode-hook 'set-up-slime-ac))

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
;;                        Other Programming Language
;; ------------------------------------------------------------------------

(use-package lsp-java
  :config
  (add-hook 'java-mode-hook #'lsp))

(use-package quickrun)

;; ------------------------------------------------------------------------
;;                           EWW (Web Browser)
;; ------------------------------------------------------------------------

(use-package eww
  :config

  ;; Disable background and txet color
  (defvar eww-disable-colorize t)
  (defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
    (unless eww-disable-colorize
      (funcall orig start end fg)))
  (advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
  (advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)

  ;; Set default browser (EWW)
  (setq browse-url-browser-function 'eww-browse-url)

  ;; disable header
  (setq eww-header-line-format nil))

;; ------------------------------------------------------------------------
;;                          Syntax Check
;; ------------------------------------------------------------------------

(use-package highlight-cl
  :straight (:host github :repo "emacsmirror/highlight-cl"))

;; Highlight symbol setting
(use-package highlight-symbol
  :config
  (global-set-key [(control f3)] 'highlight-symbol-at-point)
  (global-set-key [f3] 'highlight-symbol-next)
  (global-set-key [(shift f3)] 'highlight-symbol-prev)
  (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
  (setq highlight-symbol-idle-delay 0)
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)
  :bind (("M-s M-r" . 'highlight-symbol-query-replace)))

;; Rainbow delimiters setting
(use-package color)
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (defun rainbow-delimiters-using-stronger-colors ()
    (interactive)
    (cl-loop
     for index from 1 to rainbow-delimiters-max-face-count
     do
     (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
       (cl-callf color-saturate-name (face-foreground face) 30))))
  (add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors))

;; ------------------------------------------------------------------------
;;                              History
;; ------------------------------------------------------------------------

;; Add minor packages
(use-package redo+
  :straight (:host github :repo "emacsmirror/redo-plus")
  :bind (("C-?" . 'redo)))

;; All indent
(use-package point-undo
  :straight (:host github :repo "emacsmirror/point-undo")
  :config
  (defun all-indent ()
    (interactive)
    (mark-whole-buffer)
    (indent-region (region-beginning)(region-end))
    (point-undo))
  :bind (( "C-x C-]" . 'all-indent)))

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
  (global-unset-key "\C-t")
  (smartrep-define-key global-map "C-t"
    '(("C-t"      . 'mc/mark-next-like-this)
      ("n"        . 'mc/mark-next-like-this)
      ("p"        . 'mc/mark-previous-like-this)
      ("m"        . 'mc/mark-more-like-this-extended)
      ("u"        . 'mc/unmark-next-like-this)
      ("U"        . 'mc/unmark-previous-like-this)
      ("s"        . 'mc/skip-to-next-like-this)
      ("S"        . 'mc/skip-to-previous-like-this)
      ("*"        . 'mc/mark-all-like-this)
      ("d"        . 'mc/mark-all-like-this-dwim)
      ("i"        . 'mc/insert-numbers)
      ("o"        . 'mc/sort-regions)
      ("O"        . 'mc/reverse-regions)))
  :bind
  (("C-M-c" . 'mc/edit-lines)
   ("C-M-r" . 'mc/mark-all-in-region)))

;; Vim mode
(use-package evil
  :config (evil-mode 1)
  (setq evil-default-state 'emacs))

;; Nyan mode !!
(use-package nyan-mode
  :config
  (nyan-mode)
  (nyan-start-animation))

;; Display EOL
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; Jump cursor
(use-package ace-jump-mode
  :bind (("C-c SPC" . 'ace-jump-mode)))

;; Case-insensitive
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; Completion setting
(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1)
  :bind
  (("M-y"   . 'helm-show-kill-ring)
   ("C-c i" . 'helm-imenu)
   ("C-x b" . 'helm-buffers-list)
   ("C-h"   . 'delete-backward-char)
   ("C-h"   . 'delete-backward-char)
   ("TAB"   . 'helm-execute-persistent-action)
   ("TAB"   . 'helm-execute-persistent-action)))

;; Completion setting
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 30)
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus))))

;; Completion setting (so good M-x)
(use-package counsel
  :config (defvar counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))
  :bind
  (("M-x" . 'counsel-M-x)
   ("C-x C-f" . 'counsel-find-file)))

;; Completion setting (fuzzy)
(use-package fuzzy)

;; Find file or directory
(use-package helm-ag
  :config (setq helm-ag-base-command "ag --nocolor --nogrou")
  :bind (("C-c s" . 'helm-ag)))

;; Search file name in project
(use-package find-file-in-project
  :config (global-set-key [(super shift i)] 'find-file-in-project))

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
(use-package git-gutter
  :config (global-git-gutter-mode t))

(use-package git-complete
  :straight (:host github :repo "zk-phi/git-complete"))

(use-package fish-mode
  :mode (("\\.fish$" . fish-mode)))

;; Not crete backup files
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)
(setq backup-inhibited t)
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq version-control nil)

;; If file head line is #', add excution authority
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; Disable beep sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Highlight yank text
(defadvice yank (after ys:highlight-string activate)
  (let ((ol (make-overlay (mark t) (point))))
    (overlay-put ol 'face 'highlight)
    (sit-for 0.5)
    (delete-overlay ol)))
(defadvice yank-pop (after ys:highlight-string activate)
  (when (eq last-command 'yank)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.5)
      (delete-overlay ol))))

;; Defined in external file (package-install-selected-packages)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Highlight corresponding parenthesis
(use-package paren
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
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

(add-hook 'before-save-hook 'all-indent) ; Auto indent when before save
(add-hook 'before-save-hook 'delete-trailing-whitespace) ; Remove tail space when before save
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt) ; Hide password
(delete 'mode-line-modes mode-line-format) ; Hide monde name
(fset 'yes-or-no-p 'y-or-n-p) ; "yes or no" -> "y or n"
(global-auto-revert-mode 1) ; Auto reload buffer
(global-font-lock-mode t) ; Highlight keyword color
(global-set-key "\C-x\C-b" 'bs-show) ; Better display buffer list
(global-set-key [f5] 'redraw-display)
(global-set-key [f8] 'neotree-toggle) ; Open Directory tree
(icomplete-mode 1) ;Alway display completion candidate
(set-frame-parameter nil 'alpha 85) ; Transparency
(setq delete-auto-save-files t) ; Delete auto save file when exiting
(setq inhibit-startup-echo-area-message -1) ; Disable echo alia
(setq inhibit-startup-message t) ; Disable start-up message
(setq kill-whole-line t) ; C-k delete line
(setq-default indent-tabs-mode nil) ; Disable tab
(setq-default tab-width 2 indent-tabs-mode nil) ; Tab is 2 whitespace
(setq-default transient-mark-mode t) ; Highlight selection range
(size-indication-mode t) ; Display filesize
