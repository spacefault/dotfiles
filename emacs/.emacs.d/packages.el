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

;; olivetti
(use-package olivetti
  :defer t)

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
   (expand-file-name "~/School/Notebox"))

  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-capture))

  :config
  (org-roam-db-autosync-mode))


;; newsticker
(use-package newsticker
  :ensure nil
  :defer t
  :init

  (setq newsticker-url-list
        '(("jwz" "https://cdn.jwz.org/blog/feed/")
          ("FSF News" "https://fsf.org")
          ("XKCD" "https://xkcd.com")))

  :config
  (setq newsticker-retrieval-interval 3600
        newsticker-desc-no-html t
        newsticker-automatically-mark-items-as-old nil)

  (setq newsticker-frontend 'newsticker-treeview)

  :bind
  (("C-c n s" . newsticker-show-news)
   ("C-c n g" . newsticker-get-all-news)))

;; auctex config
(use-package auctex
  :ensure t
  :defer t
  :hook (LaTeX-mode-hook . turn-on-reftex)
  :config
  (setq-default TeX-engine 'default)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq TeX-command-force "" TeX-clean-confirm nil)
  (with-eval-after-load 'tex
    (add-to-list 'TeX-command-list
                 '("Biber" "biber %s" TeX-run-command nil t :help "Run Biber") t)))
  
(use-package reftex
  :defer t
  :config
  (setq reftex-plug-into-AUCTeX t)
  
  (setq bibtex-dialect 'biblatex)
  
  (setq LaTeX-reftex-cite-format-auto-activate nil)
  (setq reftex-cite-extra-args t)
  
  (setq reftex-cite-format
        '((?a . "\\autocite{%l}")    ; Standard parenthetical: (Smith 42)  - hit 'a' inside RefTeX
          (?t . "\\textcite{%l}")    ; Narrative citation: Smith (42)      - hit 't' inside RefTeX
          (?f . "\\footcite{%l}")    ; Footnote citation if needed         - hit 'f' inside RefTeX
          (?d . "\\cite{%l}"))))     ; Default standard cite               - hit d in reftex

;;(provide 'packages)
