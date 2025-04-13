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
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

(setq doom-font (font-spec :family "Cascadia Mono NF" :size 16)
      doom-variable-pitch-font (font-spec :family "Cascadia Code NF" :size 18))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
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

;; map
(map! "C-z" nil
      "C-x C-z" nil)

(map! "C->" #'centaur-tabs-forward
      "C-<" #'centaur-tabs-backward)

(map! "M-p" #'drag-stuff-up
      "M-n" #'drag-stuff-down)

(map! "C-0" #'treemacs-select-window)

(map! "C-<up>" #'enlarge-window
      "C-<down>" #'shrink-window
      "C-<left>" #'shrink-window-horizontally
      "C-<right>" #'enlarge-window-horizontally)

(map! "C-{" #'indent-rigidly-left-to-tab-stop
      "C-}" #'indent-rigidly-right-to-tab-stop)

(map! "C-<next>" #'centaur-tabs-move-current-tab-to-right
      "C-<prior>" #'centaur-tabs-move-current-tab-to-left)

;; ui
(use-package! whitespace
  :config
  (setq whitespace-style '(face tabs tab-mark spaces space-mark)
        whitespace-display-mappings '((space-mark ?\  [?\u00B7])
                                      (tab-mark   ?\t [?\u00BB?\t])))
  (global-whitespace-mode t))

(setq highlight-indent-guides-method 'bitmap)

(setq treemacs-width 30)

;; vterm
(add-hook! 'vterm-mode-hook #'centaur-tabs-local-mode)

;; magit
(after! magit
  (setq magit-diff-refine-hunk 'all))

(after! magit
  (setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")))

;; corfu
(after! corfu
  (setq corfu-preselect 'directory)
  (custom-set-faces!
    '(corfu-current
      :bold t
      :foreground "#ffffff"
      :background "#4f4f4f")))

(setq corfu-preview-current nil)

;; eldoc
(after! eldoc-box
  (setq eldoc-box-max-pixel-width 600
        eldoc-box-max-pixel-height 800))

(map! :leader "g" #'eldoc-box-quit-frame
      :leader "d" #'eldoc-box-help-at-point)

;;(add-hook! 'eglot-managed-mode-hook #'eldoc-box-hover-at-point-mode)

;; eglot
(map! :leader "r" #'eglot-reconnect)

(set-eglot-client! '(c-mode c++-mode)
                   '("clangd" "-j=8"
                     "--background-index"
                     "--pch-storage=disk"
                     "--fallback-style=GNU"
                     "--all-scopes-completion"
                     "--header-insertion=never"
                     "--completion-style=detailed"
                     "--query-driver=/usr/bin/gcc"))

(setq eglot-ignored-server-capabilities '(:inlayHintProvider))

;; lsp-mode
;;(setq lsp-enable-suggest-server-download nil)
;;(setq lsp-clients-clangd-executable "/usr/bin/clangd")

;;(after! lsp-clangd
;;  (setq lsp-clients-clangd-args
;;        '("-j=8"
;;          "--background-index"
;;          "--pch-storage=disk"
;;          "--fallback-style=GNU"
;;          "--all-scopes-completion"
;;          "--header-insertion=never"
;;          "--completion-style=detailed"
;;          "--query-driver=/usr/bin/gcc"))
;;  (set-lsp-priority! 'clangd 2))
