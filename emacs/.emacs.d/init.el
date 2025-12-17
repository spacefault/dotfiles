; init

(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq org-startup-indented t)
(column-number-mode)
(display-time-mode)
(display-battery-mode)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'latte) ;; or 'latte, 'macchiato, or 'mocha
(catppuccin-reload)

;(require 'evil)
;(evil-mode 1)
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
(require 'org-roam)


; org confs

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
  (set-face-attribute (car face) nil :font "Menlo" :weight 'bold :height (cdr face)))
(add-hook 'org-mode-hook 'variable-pitch-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(variable-pitch ((t (:family "Menlo")))))

; melpa

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f9d423fcd4581f368b08c720f04d206ee80b37bfb314fa37e279f554b6f415e9"
     default))
 '(package-selected-packages '(catppuccin-theme magit nix-mode org-roam)))

