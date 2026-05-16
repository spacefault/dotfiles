; init

; see early-init.el for pre-load options

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
(setq package-install-upgrade-built-in t)

; melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;(load-theme 'catppuccin :no-confirm)
;(setq catppuccin-flavor 'latte) ;; or 'latte, 'macchiato, or 'mocha
;(catppuccin-reload)

(add-hook 'rust-mode-hook 'lsp-deferred)
(require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
(require 'org-roam)


;; stop lsp from using emojis, like the lightbulb emoji for warnings
(setq lsp-modeline-code-actions-enable t)
(setq lsp-modeline-code-action-fallback-icon "Code Actions Available")
(setq lsp-modeline-code-actions-segments '(count icon))
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-modeline-diagnostics-enable t)
(setq lsp-modeline-diagnostics-scope :workspace)



(setq org-capture-templates
      '(("c" "biweekly check-in" entry
         (file "~/Documents/Planning/checkins.org")
         "* %<%Y>\n** %<%V> | %<%b %d %Y>\n\n%?"
         :jump-to-captured t
         :unnarrowed t)))


(global-set-key (kbd "C-c n c") #'org-capture)


     (setq org-roam-directory (expand-file-name "~/Documents/School/Notebox"))
      (org-roam-db-autosync-mode)
      (define-key global-map (kbd "C-c n l") 'org-roam-buffer-toggle)
      (define-key global-map (kbd "C-c n f") 'org-roam-node-find)
      (define-key global-map (kbd "C-c n i") 'org-roam-node-insert)
(dolist (face '((org-level-1 . 1.35)
                (org-level-2 . 1.3)
                (org-level-3 . 1.2)
                (org-level-4 . 1.1)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Monaspace Radon" :weight 'bold :height (cdr face)))
(add-hook 'org-mode-hook 'variable-pitch-mode)
