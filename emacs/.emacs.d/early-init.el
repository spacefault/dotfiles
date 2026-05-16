;; early init

(setq frame-resize-pixelwise t)

(setq default-frame-alist
      '((width . 165)
        (height . 65)))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq org-startup-indented t)
(column-number-mode)
(display-time-mode)
(display-battery-mode)
(savehist-mode 1)
(recentf-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)

(setq history-length 1000)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(add-to-list 'default-frame-alist
             '(font . "Monaspace Radon-12"))
