;; theme
(load-theme 'manoj-dark t)

;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

;; basic config

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)

;; No more typing the whole yes or no. Just y or n will do.
(fset 'yes-or-no-p 'y-or-n-p)

;; indentation
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; neotree
(add-to-list 'load-path "/directory/containing/neotree/")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(neotree-toggle)

;; VIM mode
(require 'evil)
(evil-mode 1)

;; colors
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(add-hook 'neotree-mode-hook
  (lambda ()
    (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
    (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

;; git gutter
(global-git-gutter-mode +1)

;; disable audible bell
(setq ring-bell-function 'ignore)

;; auto rebalance windows
(setq evil-auto-balance-windows 1)

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; tern
(defun ome-tern-setup ()
  (when (el-get-package-installed-p 'js2-mode)
    (add-hook 'js2-mode-hook (lambda () (tern-mode t))))
  (when (el-get-package-installed-p 'js3-mode)
    (add-hook 'js3-mode-hook (lambda () (tern-mode t))))
  (setq tern-command (cons (executable-find "tern") '()))
  (eval-after-load 'tern
    '(progn
       (require 'tern-auto-complete)
       (tern-ac-setup))))

;; evil-leader
(evilnc-default-hotkeys)

;; ................................................................
;; Neotree...
(add-to-list 'load-path "~/.emacs.d/vendor/neotree")
(require 'neotree)

; = Toggle (Evil) --
(define-key evil-normal-state-map "\C-u" 'neotree-toggle)
(define-key evil-insert-state-map "\C-u" 'neotree-toggle)
(define-key evil-visual-state-map "\C-u" 'neotree-toggle)
; = Enter_Open_File_anywhere (Evil) --
(define-key neotree-mode-map [return] 'neo-node-do-enter)
(define-key neotree-mode-map (kbd "\C-g") 'neotree-refresh)
(define-key neotree-mode-map (kbd "C-<return>") 'neo-node-do-change-root)

(add-hook 'neotree-mode-hook
  (lambda () (hl-line-mode 1)))

;; Org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; evil org mode
(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(require 'evil-org)

;; color-theme
(require 'color-theme)

;; command-t
(require 'command-t)

;; helm
(require 'helm)

;; helm-ack
(require 'helm-ack)

;; js2-mode
(require 'js2-mode)
