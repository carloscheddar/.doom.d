;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Carlos Feliciano-Barba"
      user-mail-address "carlos@felicianobarba.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Use the Open Source hack font https://sourcefoundry.org/hack/
(setq doom-font (font-spec :family "Hack" :size 14))

;; TODO: Add a PR to add this to the projectile module
(defun projectile-yank-relative-path ()
  "Copy the buffer's filename relative to the project path.
Prints the copied string to the mini buffer."
  (interactive)
  (let ((name (file-relative-name buffer-file-name (projectile-project-root))))
    (kill-new name)
    (message name)))

;; Change bindings to match my spacemacs muscle memory
(map! :leader "TAB" 'evil-switch-to-windows-last-buffer)
(map! :leader "w W" 'ace-window)
(map! :leader "v" 'er/expand-region)
(map! :leader ";" 'evilnc-comment-operator)
(map! :leader "p R" 'projectile-replace)
(map! :leader "p y" 'projectile-yank-relative-path)
(map! :v "s" 'evil-surround-region)

;; Change ace-window letter styling
(custom-set-faces!
  '(aw-leading-char-face
    :foreground "white" :background "red"
    :weight bold :height 2.5 :box (:line-width 10 :color "red")))

;; Set indentation for various modes
;; Source: http://blog.binchen.org/posts/easy-indentation-setup-in-emacs-for-web-development.html
(defun my-setup-indent (n)
  ;; web development
  (setq coffee-tab-width n) ; coffeescript
  (setq react-tab-width n) ; React
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq web-mode-attr-indent-offset n)
  (setq css-indent-offset n) ; css-mode
  (setq sgml-basic-offset n)
  ;; java/c/c++
  (setq c-basic-offset n))

;; Set indentation for my setup to 2
(my-setup-indent 2)

;; Converts selected region into comma separated values in 1 line
(defun rows-to-array (&optional start end)
  (interactive "r")
  (shell-command-on-region start end "xargs | sed -e 's/ /, /g'" (current-buffer) t))


;; Allow option key to work like native MacOS to enter accented characters
;; TODO: Make a PR to add this to the MacOS module
(setq mac-command-key-is-meta nil)
(setq mac-command-modifier 'super)
(setq mac-option-key-is-meta t)
(setq mac-option-modifier t)
