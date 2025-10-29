(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq org-startup-indented t)
(column-number-mode)
(display-time-mode)
(display-battery-mode)


(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)


(require 'org-roam)
(org-roam-db-autosync-mode)
; (setq org-agenda-files '("~/dev/local/orgroam/2024-2025.org"))
; (setq org-roam-directory (expand-file-name "/home/devin/docs/schoolnotes2/notebin"))
(define-key global-map (kbd "C-c n l") 'org-roam-buffer-toggle)
(define-key global-map (kbd "C-c n f") 'org-roam-node-find)
(define-key global-map (kbd "C-c n i") 'org-roam-node-insert)
