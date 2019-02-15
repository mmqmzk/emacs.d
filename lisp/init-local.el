(set-language-environment 'utf-8)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq-default pathname-coding-system 'euc-cn)
(setq file-name-coding-system 'euc-cn)
(prefer-coding-system 'cp950)
(prefer-coding-system 'gb2312)
(prefer-coding-system 'cp936)
(prefer-coding-system 'gb18030)
(prefer-coding-system 'utf-16)
(prefer-coding-system 'utf-8-dos)
(prefer-coding-system 'utf-8)

(setq tab-width 2)
(setq js-indent-level 2)

(require-package 'evil)
(evil-mode t)

(require-package 'evil-surround)
(global-evil-surround-mode t)

(require-package 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

(require-package 'evil-leader)
(global-evil-leader-mode)

(setq-default org-display-custom-times t)
(setq org-time-stamp-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))
(setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d [%H:%M]>"))

(require-package 'evil-nerd-commenter)
;; Emacs key bindings
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
(global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)
;; Vim key bindings
(evil-leader/set-key
  "cc" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncom
  "ci" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
  )

(require-package 'avy)
(global-set-key (kbd "C-'") 'avy-goto-word-1)
(global-set-key (kbd "C-0") 'avy-goto-word-0)
(global-set-key (kbd "C-|") 'avy-goto-line)
(define-key evil-normal-state-map (kbd "SPC w") 'avy-goto-word-1)
(define-key evil-normal-state-map (kbd "SPC 0") 'avy-goto-word-0)
(define-key evil-normal-state-map (kbd "SPC c") 'avy-goto-char)
(define-key evil-normal-state-map (kbd "SPC 2") 'avy-goto-char-2)
(define-key evil-normal-state-map (kbd "SPC l") 'avy-goto-line)

(if (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode)
  (global-linum-mode 1))

;; (setq org-agenda-files (list "~/org/todo.org"))

(provide 'init-local)
