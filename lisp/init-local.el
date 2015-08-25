(set-language-environment 'Chinese-gbk)
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
(prefer-coding-system 'utf-8-unix)

;; Setting English Font
(set-face-attribute
 'default nil :font "Consolas 12")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Microsoft Yahei" :size 12)))

(global-linum-mode t)
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


;; AceJump integration is now included in evil, this gist is only preserved for historical reasons.
;; Please use the provided integration (it's far more advanced)
;; AceJump is a nice addition to evil's standard motions.
;; The following definitions are necessary to define evil motions for ace-jump-mode (version 2).
;; ace-jump is actually a series of commands which makes handling by evil
;; difficult (and with some other things as well), using this macro we let it
;; appear as one.
(defmacro evil-enclose-ace-jump (&rest body)
  `(let ((old-mark (mark))
         (ace-jump-mode-scope 'window))
     (remove-hook 'pre-command-hook #'evil-visual-pre-command t)
     (remove-hook 'post-command-hook #'evil-visual-post-command t)
     (unwind-protect
         (progn
           ,@body
           (recursive-edit))
       (if (evil-visual-state-p)
           (progn
             (add-hook 'pre-command-hook #'evil-visual-pre-command nil t)
             (add-hook 'post-command-hook #'evil-visual-post-command nil t)
             (set-mark old-mark))
         (push-mark old-mark)))))
(evil-define-motion evil-ace-jump-char-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 5)))
(evil-define-motion evil-ace-jump-line-mode (count)
  :type line
  (evil-enclose-ace-jump
   (ace-jump-mode 9)))
(evil-define-motion evil-ace-jump-word-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 1)))
(evil-define-motion evil-ace-jump-char-to-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 5)
   (forward-char -1)))
(add-hook 'ace-jump-mode-end-hook 'exit-recursive-edit)
;; some proposals for binding:
(define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode)
;; (define-key evil-motion-state-map (kbd "C-;") #'evil-ace-jump-word-mode)
(define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-char-mode)
;; (define-key evil-operator-state-map (kbd "C-;") #'evil-ace-jump-char-to-mode)
;; (define-key evil-operator-state-map (kbd "M-;") #'evil-ace-jump-word-mode)
;; different jumps for different visual modes
(defadvice evil-visual-line (before spc-for-line-jump activate)
  (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-line-mode))
(defadvice evil-visual-char (before spc-for-char-jump activate)
  (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode))
(defadvice evil-visual-block (before spc-for-char-jump activate)
  (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode))

(setq org-agenda-files (list "~/org/todo.org"))
(provide 'init-local)
