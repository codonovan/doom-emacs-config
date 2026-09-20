;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Native compilation: point libgccjit's linker at gcc's runtime libs
;; (libemutls_w.a, libgcc_s, ...). Without this, native-comp fails with
;; "ld: library 'emutls_w' not found" after a gcc/Command-Line-Tools bump.
;; Globbed so it survives gcc version/SDK-triple changes.
(when (eq system-type 'darwin)
  (let* ((emutls (car (file-expand-wildcards
                       "/opt/homebrew/lib/gcc/current/gcc/*/*/libemutls_w.a")))
         (dirs (delq nil (list "/opt/homebrew/lib/gcc/current"
                               (and emutls (directory-file-name
                                            (file-name-directory emutls)))))))
    (when dirs
      (setenv "LIBRARY_PATH"
              (mapconcat #'identity
                         (append dirs
                                 (and (getenv "LIBRARY_PATH")
                                      (list (getenv "LIBRARY_PATH"))))
                         ":")))))

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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;

;; Mac is a Retina panel; the Linux box is a 32-inch 4K at 133% scale, which
;; needs a larger point size to match.
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono"
                           :size (if (featurep :system 'macos) 14 18)))

;; (setq doom-font     (font-spec :family "Source Code Pro" :size 15)
;;       doom-big-font (font-spec :family "Source Code Pro" :size 24))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(load-theme 'doom-zenburn)

;; Gruvbox Material. Upstream (sainnhe/gruvbox-material) is Vim-only and there is
;; no Emacs package, so the theme is hand-ported from its palette and lives in
;; themes/doom-gruvbox-material-theme.el — no external package to install.
;; medium + material is what matches the Ghostty and Herdr palettes
;; (bg0 #282828, fg0 #d4be98). Both must be set before the theme loads.
(setq doom-gruvbox-material-background "medium"   ; soft | medium | hard
      doom-gruvbox-material-palette    "material") ; material | mix | original
(setq doom-theme 'doom-gruvbox-material)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

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


;; Open Doom Emacs maximised
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Numbered window selection (M-1..M-5 below rely on this being on)
(use-package! winum
  :init
  ;; Number windows per-frame; the global default makes M-1..M-5 jump
  ;; between emacsclient frames.
  (setq winum-scope 'frame-local)
  :config
  (winum-mode 1))

;;(map! "M-m p f" #'projectile-find-file)
(map! "M-m p f" #'projectile-find-file
      "M-m p k" #'projectile-kill-buffers
      "M-m p s" #'+default/search-project
      "M-m b b" #'persp-switch-to-buffer
      "M-1"     #'winum-select-window-1
      "M-2"     #'winum-select-window-2
      "M-3"     #'winum-select-window-3
      "M-4"     #'winum-select-window-4
      "M-5"     #'winum-select-window-5
      "M-?"     #'lsp-ui-peek-find-references
      "<f5>"    #'magit-status
      )

(setq lsp-file-watch-ignored
      '(
        "[/\\\\]\\.git$"
        "[/\\\\]node_modules$"
        "[/\\\\]ios/Pods$"
        "[/\\\\]ios/build$"
        "[/\\\\]android/app/build$"
        "[/\\\\]android/app/.cxx$"
        "[/\\\\]mobile-app/.cache$"
        "[/\\\\]\\.clj-kondo$"
        "[/\\\\]\\.shadow-cljs$"
        ))

;;
;; Projectile config
;;
(after! projectile
  (nconc projectile-globally-ignored-directories
         '(".lsp" ".tmp" ".cache" ".local" "node_modules" ".clj-kondo")))

(after! js2-mode
  (add-to-list 'projectile-globally-ignored-directories "node_modules" ".firebase"))

;; (after! clojure-mode
;;   (add-to-list 'projectile-globally-ignored-directories ".clj-kondo"))



;; Jump to registrations of re-frame subscriptions, event handlers and fx
;;; Code:
(after! cider
  (require 'cider-util)
  (require 'cider-resolve)
  (require 'cider-client)
  (require 'cider-common)
  (require 'cider-find))

(defun re-frame-jump-to-reg ()
  (interactive)
  (let* ((kw (cider-symbol-at-point 'look-back))
         (ns-qualifier (and
                        (string-match "^:+\\(.+\\)/.+$" kw)
                        (match-string 1 kw)))
         (kw-ns (if ns-qualifier
                    (cider-resolve-alias (cider-current-ns) ns-qualifier)
                  (cider-current-ns)))
         (kw-to-find (concat "::" (replace-regexp-in-string "^:+\\(.+/\\)?" "" kw))))

    (when (and ns-qualifier (string= kw-ns (cider-current-ns)))
      (error "Could not resolve alias \"%s\" in %s" ns-qualifier (cider-current-ns)))

    (progn (cider-find-ns "-" kw-ns)
           (search-forward-regexp (concat "reg-[a-zA-Z-]*[ \\\n]+" kw-to-find) nil 'noerror))))

;; It's often better to use Doom's `map!` macro for keybindings
;; for easier discovery and potential unbinding.
   (global-set-key (kbd "M->") 're-frame-jump-to-reg) ; Original
;; (map! :leader          ; Or :leader :n (for normal mode only) etc.
;;       :desc "Jump to re-frame registration"
;;       "M->" #'re-frame-jump-to-reg)


(defun revert-all-file-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
        (revert-buffer t t t)))))


;; ──────────────────────────────────────────────────────────────────────
;; Name each terminal (emacsclient -t) frame's workspace after the terminal
;; it runs in. The zsh wrapper passes the current herdr workspace label via
;; the `terminal-workspace' frame parameter (emacsclient -F); if that's
;; absent we fall back to the tty device basename. Only tty frames are
;; affected — GUI frames (`ec') keep Doom's default "#N" behaviour.
;; Reopening `e' in the same herdr workspace reuses its workspace.
(after! persp-mode
  (defun my/ws-name-from-terminal (&optional frame)
    "Derive a workspace name for FRAME's terminal.
Prefer the `terminal-workspace' frame parameter (set by the shell wrapper to
the herdr workspace label); otherwise use the tty device basename."
    (let* ((frame (or frame (selected-frame)))
           (explicit (frame-parameter frame 'terminal-workspace))
           (tty (and (frame-live-p frame)
                     (terminal-live-p (frame-terminal frame))
                     (terminal-name (frame-terminal frame)))))
      (or (and (stringp explicit) (not (string-empty-p explicit)) explicit)
          (and (stringp tty)
               (not (member tty '("initial_terminal" "unknown")))
               (file-name-nondirectory tty)))))

  (defun my/ws-name-after-terminal-a (frame &rest _)
    "Name FRAME's freshly-created workspace after its terminal.
Reuses an existing workspace of that name (so reopening `e' in the same herdr
workspace resumes it), else renames the transient `#N' workspace, or spawns a
new one off `main'."
    (when (and (bound-and-true-p persp-mode)
               (frame-live-p frame)
               (eq (framep frame) t))        ; tty frames only
      (with-selected-frame frame
        (condition-case-unless-debug err
            (let* ((desired (my/ws-name-from-terminal frame))
                   (current (+workspace-current-name)))
              (when (and desired
                         (not (equal desired current))
                         (not (equal current persp-nil-name)))
                (cond
                 ;; A workspace with this name already exists: switch to it
                 ;; (so multiple terminals in one herdr workspace share it)
                 ;; and drop the transient `#N' we just spun up.
                 ((+workspace-exists-p desired)
                  (+workspace-switch desired)
                  (when (string-match-p "^#[0-9]+$" current)
                    (ignore-errors (+workspace-kill current))))
                 ;; Fresh `#N' created for this frame: rename it in place.
                 ((string-match-p "^#[0-9]+$" current)
                  (condition-case nil
                      (+workspace-rename current desired)
                    (error (+workspace-switch desired t))))
                 ;; First frame landed on `main' (or similar): leave that
                 ;; alone and spawn a dedicated workspace instead.
                 (t
                  (+workspace-switch desired t)))))
          (error (message "ws-name-after-terminal: %S" err))))))

  (advice-add #'+workspaces-associate-frame-fn :after
              #'my/ws-name-after-terminal-a))

;; Magit re-highlights the whole current section on every command. On a TTY
;; that repaints the section per keystroke and flickers, so keep it GUI-only.
(add-hook! 'magit-mode-hook
  (defun +magit-disable-tty-section-highlight-h ()
    (unless (display-graphic-p)
      (setq-local magit-section-highlight-current nil
                  magit-section-highlight-selection nil))))
