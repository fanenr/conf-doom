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
(setq org-directory "~/Org/")

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

(map! "M-p" #'drag-stuff-up
      "M-n" #'drag-stuff-down)

(map! "C-<up>" #'enlarge-window
      "C-<down>" #'shrink-window
      "C-<left>" #'shrink-window-horizontally
      "C-<right>" #'enlarge-window-horizontally)

(map! "C-{" #'indent-rigidly-left-to-tab-stop
      "C-}" #'indent-rigidly-right-to-tab-stop)

;; editor
(setq-default tab-width 8)

;; auto mode
(add-to-list 'auto-mode-alist '("\\.clangd\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.clang-format\\'" . yaml-mode))

;; treemacs
(use-package! treemacs
  :config
  (setq treemacs-width 32)
  :bind
  ("C-0" . treemacs-select-window))

;; whitespace
(use-package! whitespace
  :config
  (global-whitespace-mode)
  (setq highlight-indent-guides-method 'bitmap
        whitespace-style '(face tabs tab-mark spaces space-mark)
        whitespace-display-mappings '((space-mark ?\  [?\u00B7])
                                      (tab-mark   ?\t [?\u00BB?\t]))))

;; centaur-tabs
(use-package! centaur-tabs
  :bind
  ("C->" . centaur-tabs-forward)
  ("C-<" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-move-current-tab-to-right)
  ("C-<prior>" . centaur-tabs-move-current-tab-to-left))

;; vterm
(use-package! vterm
  :hook
  (vterm-mode . centaur-tabs-local-mode))

;; magit
(use-package! magit
  :config
  (setq magit-diff-refine-hunk 'all
        magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")))

;; corfu
(use-package! corfu
  :config
  (setq corfu-preview-current nil
        corfu-preselect 'directory)
  (custom-set-faces!
    '(corfu-current
      :bold t
      :foreground "#ffffff"
      :background "#4f4f4f")))

;; eldoc-box
(use-package! eldoc-box
  :config
  (setq eldoc-box-max-pixel-width 600
        eldoc-box-max-pixel-height 800)
  :bind
  (:map doom-leader-map
        ("g" . eldoc-box-quit-frame)
        ("d" . eldoc-box-help-at-point)))

;; eglot
(use-package! eglot
  :config
  (set-eglot-client! 'cmake-mode
                     '("cmake-language-server"))
  (set-eglot-client! '(c-mode c++-mode)
                     '("clangd" "-j=4"
                       "--background-index"
                       "--pch-storage=disk"
                       "--fallback-style=GNU"
                       "--all-scopes-completion"
                       "--header-insertion=never"
                       "--completion-style=detailed"
                       "--query-driver=/usr/bin/gcc"))
  :bind
  (:map doom-leader-map
        ("r" . eglot-reconnect)))

;; eglot-booster
(use-package! eglot-booster
  :config
  (eglot-booster-mode)
  (setq eglot-booster-io-only t))

;; c c++
(add-hook! (c-mode c++-mode)
  (c-set-style "gnu")
  (setq tab-width 8
        c-basic-offset 2
        eglot-ignored-server-capabilities '(:inlayHintProvider)))
