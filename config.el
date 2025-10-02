;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;org super tag 



(after! gptel
  (require 'org-supertag))

(use-package! org-supertag
  :after org
  :config
  ;; Common org-mode directory locations
  (setq org-supertag-sync-directories 
        '("~/Documents/org/supertag/"))                    ; Main org directory
  
  (setq org-supertag-bridge-enable-ai nil)
  ;; Your keybindings here...
  )

;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(set-frame-parameter nil 'alpha-background 85) ; For current frame
 (add-to-list 'default-frame-alist '(alpha-background . 85)) ; For all new frames henceforth

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Ubuntu Sans" :size 19))
;;

(after! org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((mermaid . t)
     ;; Add more languages here
     )))



;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic :family "Cascadia Code")
  '(font-lock-keyword-face :slant italic :family "Cascadia Code"))
;; ORG-MODE THEMING
;;    (add-hook 'zen-mode-hook (lambda ()
;;                               (display-line-numbers-mode -1)))

(after! writeroom-mode
  ;; Disable line numbers and relative line numbers in writeroom (Zen) mode
  (add-hook 'writeroom-mode-enable-hook (lambda ()
                                          (setq display-line-numbers nil)))

  ;; Optional: restore line numbers when leaving Zen mode
  (add-hook 'writeroom-mode-disable-hook (lambda ()
                                           (setq display-line-numbers t))))


;; quote block configs
(custom-set-faces!
  '(org-quote :extend t)
  '(org-block-begin-line :foreground "#67a162"))
;; Custom block

(defface org-block-box-face
  '((t (:background "#233c42" :foreground "#d65d0e" :extend t :slant italic)))
  "Face for my custom org block 'box'.")
(defun my/org-fontify-box-blocks (limit)
  "Fontify #+begin_box blocks with `org-block-box-face`."
  (let ((case-fold-search t))
    (when (re-search-forward "^[ \t]*#\\+begin_box\\(\\(?:.\\|\n\\)*?\\)#\\+end_box" limit t)
      (add-text-properties
       (match-beginning 0) (match-end 0)
       '(font-lock-face org-block-box-face
                        rear-nonsticky t))
      t)))
(add-hook 'org-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
             '((my/org-fontify-box-blocks)))))


;; org-roam directories
(setq org-roam-capture-templates
      '(
        ("d" "default" plain "%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :unnarrowed t)

        ("n" "Notes" plain "%?"
         :if-new (file+head "Notes/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
         )

        ("c" "CSS")
        ("cd" "default" plain "%?"
         :if-new (file+head "CSS/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
        )

        ("ce" "English" plain "%?"
         :if-new (file+head "CSS/English/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
        )

        ("ci" "Islamic-Studies" plain "%?"
         :if-new (file+head "CSS/Islamic-Studies/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
        )

        ("cc" "Current-Affairs" plain "%?"
         :if-new (file+head "CSS/Current-Affairs/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
        )

;;        ("cg" "GSA" plain "%?"
;;         :if-new (file+head "CSS/GSA/${slug}.org"
;;                            "#+title: ${title}\n")
;;         :immediate-finish t
;;         :jump-to-captured t
;;        )
        ("cg" "GSA")
        ("cgd" "GSA default" plain "%?"
         :if-new (file+head "CSS/GSA/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
         )

        ("cgp" "Physics" plain "%?"
         :if-new (file+head "CSS/GSA/Physics/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
         )

        ("cgm" "GSA default" plain "%?"
         :if-new (file+head "CSS/GSA/Maths/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
         )

        ("cm" "Maths" plain "%?"
         :if-new (file+head "CSS/Maths/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
        )

        ("cp" "Pak-Affairs" plain "%?"
         :if-new (file+head "CSS/Pak-Affairs/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :jump-to-captured t
        )

        ))

;;(custom-theme-set-faces!
;;'doom-gruvbox      
;;'(org-level-3 :inherit outline-3 :height 1.2)      
;;'(org-level-2 :inherit outline-2 :height 1.5)      
;;'(org-level-1 :inherit outline-1 :height 1.75)      
;;'(org-document-title  :height 2.0 :underline nil))


(defun org-doom-gruvbox ()
  "Enable Gruvbox Dark colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.8 "#fb4934" ultra-bold)
         (org-level-2 1.4 "#fabd2f" extra-bold)
         (org-level-3 1.2 "#b8bb26" bold)
         (org-level-4 1.1 "#83a598" semi-bold)
         (org-level-5 1.1 "#d3869b" normal)
         (org-level-6 1.1 "#928374" normal)
         (org-level-7 1.1 "#d79921" normal)
         (org-level-8 1.1 "#8ec07c" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))


;; Markdown Theming
(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8 weight: ultra-bold :foreground "#458588"))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6 weight: extra-bold :foreground "#b16286"))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.4 weight: semi-bold :foreground "#98971a"))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.3 weight: bold :foreground "#fb4934"))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.2 weight: normal :foreground "#83a598"))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.1 weight: normal :foreground "#d3869b")))))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")
(setq org-agenda-files '("~/Documents/org/agenda.org"))
(setq org-roam-directory "~/Documents/org/roam/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;


;; PDF GRUVBOX THEME 

(after! ox-latex
  ;; Always load Gruvbox theme
  (add-to-list 'org-latex-packages-alist '("" "gruvbox"))

  ;; Define Gruvbox LaTeX class with heading colors
  (add-to-list 'org-latex-classes
               '("gruvbox-article"
                 "\\documentclass[11pt]{article}
\\usepackage{gruvbox}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; Default export class
  (setq org-latex-default-class "gruvbox-article"))


;; HTML THEMING 

(after! org
  (setq org-html-head
        (concat
         "<link rel=\"stylesheet\" type=\"text/css\" href=\"file://"
         (expand-file-name "~/.config/doom/gruvbox.css")
         "\" />")))


;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
