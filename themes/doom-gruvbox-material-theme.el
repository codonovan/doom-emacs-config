;;; doom-gruvbox-material-theme.el --- sainnhe's Gruvbox Material -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Source: https://github.com/sainnhe/gruvbox-material
;;
;;; Commentary:
;;
;; A local port of Gruvbox Material, which upstream ships for Vim/Neovim only
;; (there is no official Emacs theme and none on MELPA). Every colour below is
;; taken verbatim from `gruvbox_material#get_palette()' in the upstream
;; autoload/gruvbox_material.vim, so this tracks the real palette rather than an
;; eyeballed approximation.
;;
;; Upstream composes a palette from two independent axes, both mirrored here:
;;
;;   `doom-gruvbox-material-background' -- hard | medium | soft  (background contrast)
;;   `doom-gruvbox-material-palette'    -- material | mix | original  (accent saturation)
;;
;; The default (medium + material) is the muted, low-contrast look the theme is
;; known for, and matches the Ghostty ("Gruvbox Material Dark") and Herdr
;; palettes configured alongside it.
;;
;;; Code:

(require 'doom-themes)

;; Compiler pacifier
(defvar modeline-bg)


;;
;;; Variables

(defgroup doom-gruvbox-material-theme nil
  "Options for doom-gruvbox-material."
  :group 'doom-themes)

(defcustom doom-gruvbox-material-background "medium"
  "Background contrast: \"hard\", \"medium\" or \"soft\".
Anything else is treated as \"medium\"."
  :group 'doom-gruvbox-material-theme
  :type 'string)

(defcustom doom-gruvbox-material-palette "material"
  "Accent palette: \"material\", \"mix\" or \"original\".
\"material\" is the muted default; \"original\" is the classic, highly
saturated Gruvbox accent set. Anything else is treated as \"material\"."
  :group 'doom-gruvbox-material-theme
  :type 'string)

(defcustom doom-gruvbox-material-italic-comments t
  "If non-nil, italicise comments (upstream's default)."
  :group 'doom-gruvbox-material-theme
  :type 'boolean)

(defcustom doom-gruvbox-material-brighter-comments nil
  "If non-nil, render comments in a lighter grey."
  :group 'doom-gruvbox-material-theme
  :type 'boolean)

(defcustom doom-gruvbox-material-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-gruvbox-material-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-gruvbox-material
  "A dark theme with soft, muted 'retro groove' colors."
  :family 'doom-gruvbox-material
  :background-mode 'dark

  ;; Upstream palette1 (backgrounds) varies by contrast; palette2 (fg/accents)
  ;; varies by palette; palette3 (greys) is fixed for dark.
  ;;
  ;; name       gui       256       16
  ((bg
    (cond ((equal doom-gruvbox-material-background "hard") '("#1d2021" "#1d2021" nil))
          ((equal doom-gruvbox-material-background "soft") '("#32302f" "#323232" nil))
          (t                                               '("#282828" "#282828" nil))))  ; bg0
   (bg-alt
    (cond ((equal doom-gruvbox-material-background "hard") '("#141617" "black"   nil))
          ((equal doom-gruvbox-material-background "soft") '("#252423" "#252423" nil))
          (t                                               '("#1b1b1b" "#1b1b1b" nil))))  ; bg_dim
   ;; bg3 -- region, selection, hl-line
   (bg-alt2
    (cond ((equal doom-gruvbox-material-background "hard") '("#3c3836" "#3c3836" "brown"))
          ((equal doom-gruvbox-material-background "soft") '("#504945" "#504945" "brown"))
          (t                                               '("#45403d" "#45403d" "brown"))))

   (base0      '("#141617" "black"   "black"      ))          ; bg_dim (hard)
   (base1      '("#1d2021" "#1d2021" "brightblack"))          ; bg0 (hard)
   (base2      '("#282828" "#282828" "brightblack"))          ; bg0 (medium)
   (base3
    (cond ((equal doom-gruvbox-material-background "hard") '("#282828" "#282828" "brightblack"))
          ((equal doom-gruvbox-material-background "soft") '("#3c3836" "#3c3836" "brightblack"))
          (t                                               '("#32302f" "#32302f" "brightblack")))) ; bg1
   (base4
    (cond ((equal doom-gruvbox-material-background "hard") '("#504945" "#504945" "brightblack"))
          ((equal doom-gruvbox-material-background "soft") '("#665c54" "#665c54" "brightblack"))
          (t                                               '("#5a524c" "#5a524c" "brightblack")))) ; bg5
   (base5      '("#7c6f64" "#7c6f64" "brightblack"))          ; grey0
   (base6      '("#928374" "#928374" "brightblack"))          ; grey1
   (base7      '("#a89984" "#a89984" "brightblack"))          ; grey2
   (base8      '("#ddc7a1" "#ddc7a1" "brightwhite"))          ; fg1

   (fg
    (cond ((equal doom-gruvbox-material-palette "mix")      '("#e2cca9" "#e2cca9" "brightwhite"))
          ((equal doom-gruvbox-material-palette "original") '("#ebdbb2" "#ebdbb2" "brightwhite"))
          (t                                                '("#d4be98" "#d4be98" "brightwhite")))) ; fg0
   (fg-alt     '("#a89984" "#a89984" "white"))                ; grey2

   ;; palette3 -- greys (identical across all dark variants)
   (grey        '("#928374" "#928374" "brightblack"))         ; grey1

   ;; palette2 -- accents
   (red
    (cond ((equal doom-gruvbox-material-palette "mix")      '("#f2594b" "#f2594b" "red"))
          ((equal doom-gruvbox-material-palette "original") '("#fb4934" "#fb4934" "red"))
          (t                                                '("#ea6962" "#ea6962" "red"))))
   (orange
    (cond ((equal doom-gruvbox-material-palette "mix")      '("#f28534" "#f28534" "brightred"))
          ((equal doom-gruvbox-material-palette "original") '("#fe8019" "#fe8019" "brightred"))
          (t                                                '("#e78a4e" "#e78a4e" "brightred"))))
   (yellow
    (cond ((equal doom-gruvbox-material-palette "mix")      '("#e9b143" "#e9b143" "yellow"))
          ((equal doom-gruvbox-material-palette "original") '("#fabd2f" "#fabd2f" "yellow"))
          (t                                                '("#d8a657" "#d8a657" "yellow"))))
   (green
    (cond ((equal doom-gruvbox-material-palette "mix")      '("#b0b846" "#b0b846" "green"))
          ((equal doom-gruvbox-material-palette "original") '("#b8bb26" "#b8bb26" "green"))
          (t                                                '("#a9b665" "#a9b665" "green"))))
   (blue
    (cond ((equal doom-gruvbox-material-palette "mix")      '("#80aa9e" "#80aa9e" "brightblue"))
          ((equal doom-gruvbox-material-palette "original") '("#83a598" "#83a598" "brightblue"))
          (t                                                '("#7daea3" "#7daea3" "brightblue"))))
   ;; aqua -- upstream's sixth accent; Doom calls this teal/cyan
   (teal
    (cond ((equal doom-gruvbox-material-palette "mix")      '("#8bba7f" "#8bba7f" "cyan"))
          ((equal doom-gruvbox-material-palette "original") '("#8ec07c" "#8ec07c" "cyan"))
          (t                                                '("#89b482" "#89b482" "cyan"))))
   ;; purple -- identical across all three palettes upstream
   (violet      '("#d3869b" "#d3869b" "brightmagenta"))
   (magenta     '("#d3869b" "#d3869b" "magenta"))

   (cyan        teal)
   (dark-cyan   (doom-darken teal 0.2))
   (dark-blue   (doom-darken blue 0.2))
   (dark-yellow (doom-darken yellow 0.15))
   (dark-green  (doom-darken green 0.15))

   ;; face categories -- following upstream's Vim highlight groups: keywords are
   ;; red, functions/strings green, types yellow, constants/numbers purple,
   ;; identifiers blue, specials orange.
   (highlight      yellow)
   (vertical-bar   bg-alt2)
   (selection      bg-alt2)
   (builtin        orange)
   (comments       (if doom-gruvbox-material-brighter-comments base6 base5))
   (doc-comments   (if doom-gruvbox-material-brighter-comments (doom-lighten base6 0.2) base6))
   (constants      violet)
   (functions      green)
   (keywords       red)
   (methods        green)
   (operators      orange)
   (type           yellow)
   (strings        green)
   (variables      blue)
   (numbers        violet)
   (region         bg-alt2)
   (error          red)
   (warning        yellow)
   (success        green)

   (vc-modified    blue)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (-modeline-pad
    (when doom-gruvbox-material-padded-modeline
      (if (integerp doom-gruvbox-material-padded-modeline)
          doom-gruvbox-material-padded-modeline
        4)))
   ;; bg_statusline1 / bg_statusline3
   (modeline-bg          base3)
   (modeline-fg          base8)
   (modeline-inactive-bg bg-alt)
   (modeline-inactive-fg base5)

   ;; upstream's diff backgrounds (medium/dark)
   (diff-bg-red    '("#402120" "#402120" nil))
   (diff-bg-green  '("#34381b" "#34381b" nil))
   (diff-bg-blue   '("#0e363e" "#0e363e" nil))

   (org-quote `(,(doom-lighten (car bg) 0.05) "#32302f")))


  ;;;; Base theme face overrides
  ((button :foreground blue :underline t :weight 'bold)
   (cursor :background fg)
   (hl-line :background base3)
   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :background base3 :foreground yellow :weight 'bold)
   ((font-lock-comment-face &override)
    :slant (if doom-gruvbox-material-italic-comments 'italic 'normal))
   (isearch :foreground bg :background yellow :weight 'bold)
   (lazy-highlight :foreground bg :background blue :distant-foreground bg :weight 'bold)
   ((link &override) :foreground blue :underline t)
   (minibuffer-prompt :foreground green :weight 'bold)
   (match :foreground yellow :weight 'bold)
   (show-paren-match :foreground bg :background orange :weight 'bold)
   (show-paren-mismatch :foreground bg :background red :weight 'bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-inactive-bg :foreground modeline-inactive-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-inactive-bg)))
   (mode-line-emphasis :foreground green)

   ;;;; doom-emacs
   (+workspace-tab-selected-face :background green :foreground bg :weight 'bold)
   ;;;; doom-modeline
   (doom-modeline-bar               :background green)
   (doom-modeline-panel             :background green :foreground bg)
   (doom-modeline-project-dir       :foreground green :weight 'bold)
   (doom-modeline-buffer-path       :foreground teal :weight 'bold)
   (doom-modeline-buffer-file       :foreground fg   :weight 'bold)
   (doom-modeline-buffer-modified   :foreground yellow :weight 'bold)
   (doom-modeline-buffer-major-mode :foreground blue :weight 'bold)
   (doom-modeline-info              :foreground green)
   (doom-modeline-warning           :foreground yellow)
   (doom-modeline-urgent            :foreground red)
   ;;;; doom-themes
   (doom-themes-treemacs-file-face       :foreground fg)
   (doom-themes-treemacs-root-face       :foreground green :weight 'bold)
   (doom-themes-neotree-file-face        :foreground fg)
   (doom-themes-neotree-hidden-file-face :foreground base5)
   (doom-themes-neotree-media-file-face  :foreground base5)

   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-inactive-bg)))

   ;;;; company
   (company-tooltip                      :background base3 :foreground fg)
   (company-tooltip-selection            :background bg-alt2 :weight 'bold)
   (company-tooltip-common               :foreground green :weight 'bold)
   (company-tooltip-common-selection     :foreground green :weight 'bold)
   (company-tooltip-annotation           :foreground blue)
   (company-tooltip-annotation-selection :foreground blue)
   (company-tooltip-mouse                :background bg-alt2 :foreground nil)
   (company-preview-common               :foreground green)
   (company-scrollbar-bg                 :background base3)
   (company-scrollbar-fg                 :background base5)

   ;;;; corfu
   (corfu-default :background base3 :foreground fg)
   (corfu-current :background bg-alt2 :foreground fg :weight 'bold)
   (corfu-bar     :background base5)
   (corfu-border  :background bg-alt2)

   ;;;; vertico / selectrum / orderless
   (vertico-current                :background bg-alt2 :weight 'bold)
   (orderless-match-face-0         :foreground green  :weight 'bold)
   (orderless-match-face-1         :foreground orange :weight 'bold)
   (orderless-match-face-2         :foreground blue   :weight 'bold)
   (orderless-match-face-3         :foreground violet :weight 'bold)
   ;;;; marginalia
   (marginalia-documentation :foreground base6 :slant 'italic)

   ;;;; dired
   (dired-directory :foreground blue :weight 'bold)
   (dired-header    :foreground green :weight 'bold)
   (dired-marked    :foreground yellow :weight 'bold)
   (dired-symlink   :foreground teal)

   ;;;; flycheck / flymake
   (flycheck-error   :underline `(:style wave :color ,red))
   (flycheck-warning :underline `(:style wave :color ,yellow))
   (flycheck-info    :underline `(:style wave :color ,blue))
   (flymake-error    :underline `(:style wave :color ,red))
   (flymake-warning  :underline `(:style wave :color ,yellow))
   (flymake-note     :underline `(:style wave :color ,blue))

   ;;;; lsp-mode / lsp-ui
   (lsp-face-highlight-textual :background bg-alt2 :weight 'bold)
   (lsp-face-highlight-read    :background bg-alt2 :weight 'bold)
   (lsp-face-highlight-write   :background bg-alt2 :weight 'bold)
   (lsp-ui-peek-highlight      :foreground bg :background yellow)
   (lsp-ui-peek-selection      :foreground bg :background blue)
   (lsp-ui-doc-background      :background base3)
   (lsp-ui-sideline-code-action :foreground yellow)

   ;;;; magit
   (magit-branch-local          :foreground blue)
   (magit-branch-remote         :foreground green)
   (magit-section-heading       :foreground yellow :weight 'bold)
   (magit-section-highlight     :background base3)
   (magit-diff-added            :foreground green :background diff-bg-green)
   (magit-diff-added-highlight  :foreground green :background (doom-lighten diff-bg-green 0.1) :weight 'bold)
   (magit-diff-removed          :foreground red   :background diff-bg-red)
   (magit-diff-removed-highlight :foreground red  :background (doom-lighten diff-bg-red 0.1) :weight 'bold)
   (magit-diff-hunk-heading           :foreground base7 :background bg-alt2)
   (magit-diff-hunk-heading-highlight :foreground fg :background base4 :weight 'bold)
   (magit-diff-context           :foreground base6)
   (magit-diff-context-highlight :foreground fg-alt :background base3)

   ;;;; diff-hl / git-gutter
   (diff-hl-insert :foreground green :background green)
   (diff-hl-delete :foreground red :background red)
   (diff-hl-change :foreground blue :background blue)

   ;;;; ediff
   (ediff-fine-diff-A    :background (doom-blend red bg 0.4) :weight 'bold)
   (ediff-current-diff-A :background (doom-blend red bg 0.2))
   (ediff-fine-diff-B    :background (doom-blend green bg 0.4) :weight 'bold)
   (ediff-current-diff-B :background (doom-blend green bg 0.2))

   ;;;; evil
   (evil-ex-substitute-replacement :foreground green :strike-through nil
                                   :inherit 'evil-ex-substitute-matches)
   ;;;; evil-snipe
   (evil-snipe-first-match-face :foreground bg :background yellow)
   (evil-snipe-matches-face     :foreground yellow :weight 'bold :underline t)

   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground blue)
   (rainbow-delimiters-depth-2-face :foreground orange)
   (rainbow-delimiters-depth-3-face :foreground green)
   (rainbow-delimiters-depth-4-face :foreground violet)
   (rainbow-delimiters-depth-5-face :foreground teal)
   (rainbow-delimiters-depth-6-face :foreground yellow)
   (rainbow-delimiters-depth-7-face :foreground red)
   (rainbow-delimiters-unmatched-face :foreground red :weight 'bold)

   ;;;; cider / clojure
   (cider-result-overlay-face    :background base3 :box `(:line-width -1 :color ,base4))
   (cider-test-success-face      :foreground bg :background green)
   (cider-test-failure-face      :foreground bg :background red)
   (cider-test-error-face        :foreground bg :background orange)
   (cider-fringe-good-face       :foreground green)
   (cider-deprecated-face        :background (doom-blend yellow bg 0.2))
   (clojure-keyword-face         :foreground violet)

   ;;;; elisp
   (highlight-quoted-symbol :foreground teal)
   (highlight-quoted-quote  :foreground orange)

   ;;;; markdown-mode
   (markdown-header-face-1     :foreground red    :weight 'bold)
   (markdown-header-face-2     :foreground orange :weight 'bold)
   (markdown-header-face-3     :foreground yellow :weight 'bold)
   (markdown-header-face-4     :foreground green  :weight 'bold)
   (markdown-header-face-5     :foreground blue   :weight 'bold)
   (markdown-header-face-6     :foreground violet :weight 'bold)
   (markdown-markup-face       :foreground base6)
   (markdown-inline-code-face  :foreground green :background base3)
   (markdown-code-face         :background base3)
   (markdown-link-face         :foreground blue :underline t)

   ;;;; org-mode
   ((org-block &override)            :background base3)
   ((org-block-begin-line &override) :background base3 :foreground base6 :slant 'italic)
   ((org-quote &override)            :background org-quote :slant 'italic)
   (org-level-1 :foreground red    :weight 'bold :height 1.15)
   (org-level-2 :foreground orange :weight 'bold)
   (org-level-3 :foreground yellow :weight 'bold)
   (org-level-4 :foreground green  :weight 'bold)
   (org-level-5 :foreground blue   :weight 'bold)
   (org-level-6 :foreground teal   :weight 'bold)
   (org-level-7 :foreground violet :weight 'bold)
   (org-level-8 :foreground fg     :weight 'bold)
   (org-todo    :foreground red    :weight 'bold)
   (org-done    :foreground green  :weight 'bold)
   (org-headline-done :foreground base5)
   (org-code    :foreground green  :background base3)
   (org-verbatim :foreground yellow)
   (org-table   :foreground blue)
   (org-date    :foreground teal :underline t)
   (org-link    :foreground blue :underline t)

   ;;;; which-key
   (which-key-key-face                   :foreground green)
   (which-key-group-description-face     :foreground violet)
   (which-key-command-description-face   :foreground fg)
   (which-key-local-map-description-face :foreground yellow)

   ;;;; ivy / helm / swiper (in case they're ever enabled)
   (ivy-current-match          :background bg-alt2 :distant-foreground nil :weight 'bold)
   (ivy-minibuffer-match-face-1 :foreground green :weight 'bold)
   (helm-selection            :background bg-alt2 :weight 'bold)
   (helm-swoop-target-line-face :foreground violet :inverse-video t)

   ;;;; tooltips / popups
   (tooltip :background base3 :foreground fg))


  ;;;; Base theme variable overrides
  ())

;;; doom-gruvbox-material-theme.el ends here
(provide-theme 'doom-gruvbox-material)
