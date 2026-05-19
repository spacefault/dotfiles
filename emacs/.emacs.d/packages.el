;;; packages.el --- package configuration -*- lexical-binding: t; -*-

(setq package-install-upgrade-built-in t)

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

;; themes
;;
;;(use-package catppuccin-theme
;;  :config
;;  (setq catppuccin-flavor 'latte)
;;  (load-theme 'catppuccin t))

;; lsp (lsp-mode)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom
  (lsp-modeline-code-actions-enable t)
  (lsp-modeline-code-action-fallback-icon
   "Code Actions Available")
  (lsp-modeline-code-actions-segments '(count icon))
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-modeline-diagnostics-enable t)
  (lsp-modeline-diagnostics-scope :workspace))

;; rust-mode

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp-deferred))

;; org

(use-package org
  :custom
  (org-capture-templates
   '(("c" "biweekly check-in" entry
      (file "~/Documents/Planning/checkins.org")
      "* %<%Y>\n** %<%V> | %<%b %d %Y>\n\n%?"
      :jump-to-captured t
      :unnarrowed t)))

  :hook (org-mode . variable-pitch-mode)

  :config
  (dolist (face '((org-level-1 . 1.35)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute
     (car face)
     nil
     :font "Monaspace Radon"
     :weight 'bold
     :height (cdr face))))

;; org-roam

(use-package org-roam
  :after org
  :custom
  (org-roam-directory
   (expand-file-name "~/Documents/School/Notebox"))

  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-capture))

  :config
  (org-roam-db-autosync-mode))

;;(provide 'packages)
