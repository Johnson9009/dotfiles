;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (ivy :variables
          ;; Ignore internal buffers in buffer switch.
          ivy-ignore-buffers '("\*.*" "magit[:-].*")
          ;; Only ignore father dir(..) in "counsel find file", current dir(.)
          ;; is useful for the situations that need select directory, e.g.,
          ;; searching some text in all files under some directory recursively.
          ivy-extra-directories '("./"))
     (auto-completion :variables
                      auto-completion-tab-key-behavior 'nil)
     better-defaults
     emacs-lisp
     git
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     org
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-enable-clang-support t)
     (python :variables
             python-fill-column 80)
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(xclip
                                      yasnippet-snippets)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(evil-unimpaired
                                    evil-ediff
                                    clean-aindent-mode)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(monokai
                         spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Monaco for Powerline"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key nil
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'nil
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode'
   ;; and `text-mode' derivatives. If set to `relative', line numbers are
   ;; relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; Disable checking whether set PATH in shell runtime configuration file or
  ;; not.
  (setq exec-path-from-shell-check-startup-files nil)
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (define-key evil-normal-state-map (kbd "m") 'evil-emacs-state)
  (define-key evil-normal-state-map
    (kbd "C-n") (enter-emacs-state-and-move-line next))
  (define-key evil-normal-state-map
    (kbd "C-p") (enter-emacs-state-and-move-line previous))
  (define-key evil-normal-state-map (kbd "C-@") 'enter-emacs-state-and-set-mark)
  (define-key evil-normal-state-map
    (kbd "C-SPC") 'enter-emacs-state-and-set-mark)
  ;; Swap key bindings of "p" and "P" and after pasting keep cursor to the end
  ;; of pasted text.
  (define-key evil-normal-state-map
    (kbd "p") (paste-and-cursor-behind-pasted-text before))
  (define-key evil-normal-state-map
    (kbd "P") (paste-and-cursor-behind-pasted-text after))
  ;; Escape from "evil-emacs-state" to "evil-normal-state" when press "ESC"
  ;; twice consecutive, this key binding is useful for working in high latency
  ;; network, because "evil-escape-key-sequence" can't work very well in this
  ;; situation. Escape from "evil-emacs-state" to "evil-normal-state" by only
  ;; press "ESC" once is not executable, the reason has something to do with
  ;; "meta-prefix-char". Because "meta-prefix-char" equals to "ESC", thus any of
  ;; key bindings using Meta key such as "M-f" actually is "ESC-f", so if "ESC"
  ;; is binded to escaping to "evil-normal-state" through
  ;; `(define-key evil-emacs-state-map (kbd "ESC") 'evil-normal-state)`, then
  ;; all of the key bindings using Meta key can't be used in "evil-emacs-state".
  (define-key evil-emacs-state-map (kbd "ESC ESC") 'evil-normal-state)
  ;; Escape from "evil-insert-state" to "evil-normal-state" when press "ESC" one
  ;; or more times immediately, just as above explanation, this key binding will
  ;; cause all of the key bindings using Meta key can't work in
  ;; "evil-insert-state", but it is acceptable because Meta key almost never
  ;; used by Vim's key bindings.
  (define-key evil-insert-state-map (kbd "ESC") 'evil-normal-state)
  ;; Do the same action when press "ESC" one or more times and avoid the error
  ;; message "ESC <escape> is undefined".
  (define-key evil-normal-state-map (kbd "ESC <escape>") (kbd "<escape>"))
  ;; Change some leader key bindings.
  (spacemacs/set-leader-keys
    "bk"  'kill-buffer-and-window
    "w-"  (split-and-focus-scratch below)
    "w/"  (split-and-focus-scratch right))
  ;; Mouse scrolling doesn't work when emacs is run in Mac OSX terminal. The
  ;; root cause is that mwheel.el set "mouse-wheel-up-event" and
  ;; "mouse-wheel-down-event" to "wheel-down" and "wheel-up" because of "ns-win"
  ;; always in "features" of emacs no matter emacs is launched in GUI or
  ;; terminal environment. In addition, the mouse wheel keys received from
  ;; terminal is "mouse-4" and "mouse-5", received from GUI is "wheel-up" and
  ;; "wheel-down". So change the values of "mouse-wheel-up-event" and
  ;; "mouse-wheel-down-event" can't make emacs GUI and terminal clients work
  ;; well at the same time when they connect to the same emacs daemon.
  (if (featurep 'ns)
      (progn
        (global-set-key (kbd "<mouse-4>") (kbd "<wheel-up>"))
        (global-set-key (kbd "<mouse-5>") (kbd "<wheel-down>"))))
  ;; Replace "backward-kill-word" with "backward-delete-word" to avoid the
  ;; deleted text being added to kill ring.
  (global-set-key
   (kbd "M-DEL") (lambda (arg)
                   (interactive "p")
                   (delete-region (point) (progn
                                            (forward-word (- arg))
                                            (point)))))

  ;; Ignore hidden files in "counsel find file" default, these files will appear
  ;; unless we input "."
  (setq counsel-find-file-ignore-regexp "\\`\\.")
  ;; Use the input to replace the selected region.
  (delete-selection-mode 1)
  ;; Only highlight the lines longer than value of variable "fill-column".
  (setq whitespace-line-column nil)
  (setq whitespace-display-mappings
        '((space-mark 32 [183]) ; 32 space, 183 middle dot「·」
          (newline-mark 10 [182 10]) ; 10 newline, 182 pilcrow sign「¶」
          (tab-mark 9 [8677 9]) ; 9 tab, 8677 rightwards arrow to bar「⇥」
          ))
  ;; Always delete and copy recursively in Dired mode.
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  ;; Prevent dired-mode to create so many different temporary buffers.
  (put 'dired-find-alternate-file 'disabled nil)
  (with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
  ;; The default value is (5 ((shift) . 1) ((control) . nil)), it means emacs
  ;; will scroll 5 lines when mouse wheel spin one step without any modifier key
  ;; depressed, if the "shift" key depressed when mouse wheel spinning, then
  ;; emacs only will scroll 1 line, if the "control" key depressed then emacs
  ;; will scroll one screen. Scrolling 1 line per mouse wheel spin step is more
  ;; smooth.
  (setq mouse-wheel-scroll-amount '(1))
  ;; Use the default value of right margin(80), and turn it on for all text and
  ;; programming modes.
  (spacemacs/add-to-hooks 'turn-on-fci-mode '(text-mode-hook prog-mode-hook))
  ;; Save the current user buffer automatically when exit the evil emacs state.
  (add-hook 'evil-emacs-state-exit-hook 'save-user-current-buffer)
  ;; The priority of "buffer-display-table" is higher than it of
  ;; "standard-display-table", and it isn't ensured that the
  ;; "buffer-display-table" is initialized from "standard-display-table". So the
  ;; hook added to "find-file-hook" is needed to change glyphs of
  ;; "buffer-display-table", in addition, the glyphs of "standard-display-table"
  ;; still need to be changed, because internal buffers(e.g., buffers of magit,
  ;; minibuffers and so on) won't trigger the "find-file-hook".
  (funcall (change-glyphs-of-display-table standard))
  (add-hook 'find-file-hook (change-glyphs-of-display-table buffer))
  ;; Center the screen after all below functions called, the parameter "&rest _"
  ;; of lambda function can't be ignored, otherwise the lambda function will
  ;; can't work.
  (let ((scroll-to-center (lambda (&rest _) (recenter))))
    (advice-add 'spacemacs/jump-to-definition :after scroll-to-center)
    (advice-add 'find-function :after scroll-to-center)
    (advice-add 'find-variable :after scroll-to-center)
    (advice-add 'evil-goto-line :after scroll-to-center))
  ;; Enable company mode globally and enable both vim and emacs style key
  ;; bindings of company mode. Key bindings of the style(vim) which represented
  ;; by "dotspacemacs-editing-style" will be enabled by default, key bindings of
  ;; emacs style can't be enabled automatically even though auto-completion
  ;; layer add "spacemacs//company-active-navigation" to the hook
  ;; "spacemacs-editing-style-hook", because this hook won't be executed when
  ;; evil switch state between normal and emacs. The company mode must be
  ;; enabled globally, or function "spacemacs//company-active-navigation" can't
  ;; be called at here.
  (global-company-mode)
  (spacemacs//company-active-navigation 'emacs)
  (define-key company-active-map (kbd "C-f") 'company-complete-selection)
  ;; Prevent the replaced text to be added to the kill ring, so that the copied
  ;; text can be used to replace other text multiple times.
  (setq evil-kill-on-visual-paste nil)
  ;; Allow the cursor be moved past the last character of a line in
  ;; "evil-normal-state".
  (setq evil-move-beyond-eol t)

  ;; Change cursor type of evil emacs state from box to bar.
  (setq evil-emacs-state-cursor '("SkyBlue2" (bar . 2)))

  ;; Change cursor shape and color dynamically according to evil state, match
  ;; cursor color with evil state color, when emacs or emacsclient is running in
  ;; terminal. Current implementation depends on xterm escape sequence
  ;; DECSCUSR(CSI Ps SP q) and OSC(Operating System Commands) 12, so this
  ;; feature should only be enabled in terminals which support these escape
  ;; sequences. AFAIK, mintty, `Apple Terminal.app`(need plugin manager
  ;; `MacForge` to install plugin `MouseTerm plus`) and `Gnome Terminal` can
  ;; support them.
  (advice-add 'evil-set-cursor :after #'xterm-set-cursor-shape)
  (advice-add 'evil-set-cursor-color :after #'xterm-set-cursor-color)
  (advice-add 'delete-frame :before #'xterm-reset-cursor)

  ;; Below settings only have effects for GUI emacs.

  ;; GUI emacs use wave as the separator, on Mac the separators are less
  ;; saturated than the rest of the spaceline. Using utf-8 separator makes it go
  ;; away completely without the need to change color space.
  (setq powerline-default-separator 'utf-8)
  ;; Set the highlight background of current line to black, this make selected
  ;; region become more distinct.
  (set-face-background 'hl-line "#000000")

  ;; Below settings maybe failed in some platform, in order to avoid affecting
  ;; the executing of other settings, so place them at the bottom of
  ;; "dotspacemacs/user-config".

  ;; Copy to or paste from system clipboard when spacemacs is running in
  ;; terminal.
  (xclip-mode 1)
  )

;; User defined macros and functions.

;; Enter "evil-emacs-state" firstly, and then move cursor to next or previous
;; line according to the value of parameter "direction".
(defmacro enter-emacs-state-and-move-line (direction)
  `(lambda ()
     (interactive)
     (evil-emacs-state)
     (,(intern (format "%s-line" direction)))))

;; Paste copied text before or after the cursor according to the value of
;; parameter "position", and then forward the cursor one character to keep the
;; cursor to the end of pasted text.
(defmacro paste-and-cursor-behind-pasted-text (position)
  `(lambda (count)
     (interactive "P<x>")
     (,(intern (format "evil-paste-%s" position)) count)
     (forward-char)))

;; Split window below or right according to the value of parameter "direction"
;; and focus on it, then switch to scratch buffer.
(defmacro split-and-focus-scratch (direction)
  `(lambda ()
     (interactive)
     (,(intern (format "split-window-%s-and-focus" direction)))
     (spacemacs/switch-to-scratch-buffer)))

;; Change the glyphs of "wrap", "truncation" and "vertical-border" in the
;; display table specified by parameter "name", obviously "↩", "…" and "ǁ" is
;; better choice than the default values "\", "$" and "|".
(defmacro change-glyphs-of-display-table (name)
  (let ((display-table (intern (format "%s-display-table" name))))
    `(lambda ()
       (interactive)
       (unless ,display-table
         (setq ,display-table (make-display-table)))
       (set-display-table-slot ,display-table 'wrap ?\↩)
       (set-display-table-slot ,display-table 'truncation ?\…)
       (set-display-table-slot ,display-table 'vertical-border ?\ǁ))))

(defun enter-emacs-state-and-set-mark (arg)
  "Enter \"evil-emacs-state\" firstly, and then set mark at the current
position of cursor."
  (interactive "P")
  (evil-emacs-state)
  (set-mark-command arg))

;; Save user's current buffer if there are any changes.
(defun save-user-current-buffer ()
  "Only care about the user's buffer, all the internal buffers will be ignored."
  (interactive)
  (if (not (string-match-p "^\*" (buffer-name)))
      (save-buffer)))

;; Change cursor shape and color dynamically using xterm escape sequences when
;; emacs or emacsclient is running under terminal.

(defun send-to-terminal-twice (seq)
  "Send escape sequence to terminal twice."
  (when seq
    (send-string-to-terminal seq)
    ;; In case of the escape sequence lost or isn't processed completely by
    ;; the terminal.
    (send-string-to-terminal seq)))

;; Construct cursor shape setting escape sequence of xterm and send it to
;; terminal according to the current value of `cursor-type`.
(defun xterm-set-cursor-shape (&rest _)
  "Set cursor shape."
  ;; Only continue when emacs or emacsclient is running in terminal.
  (unless (display-graphic-p)
    (let ((prefix     "\e[")
          (suffix     " q")
          (box-blink  "1")
          (hbar-blink "3")
          (bar-blink  "5")
          (shape      nil)
          (seq        nil))
      (cond ((symbolp cursor-type)
             (setq shape cursor-type))
            ((listp cursor-type)
             (setq shape (car cursor-type))))
      (cond ((eq shape 'box)
             (setq seq (concat prefix box-blink suffix)))
            ((eq shape 'bar)
             (setq seq (concat prefix bar-blink suffix)))
            ((eq shape 'hbar)
             (setq seq (concat prefix hbar-blink suffix))))
      (send-to-terminal-twice seq))))

;; Construct cursor color setting escape sequence of xterm and send it to
;; terminal.
(defun xterm-set-cursor-color (color &rest _)
  "Set cursor color."
  ;; Only continue when emacs or emacsclient is running in terminal.
  (unless (display-graphic-p)
    (let ((hex-color (apply 'color-rgb-to-hex (color-name-to-rgb color))))
      (if hex-color
          (send-to-terminal-twice (concat "\e]12;" hex-color "\a"))))))

;; Construct cursor shape and color resetting escape sequences of xterm and send
;; it to terminal, reset the shape to blink bar and the color to light orange.
(defun xterm-reset-cursor (&rest _)
  "Reset cursor shape and color."
  ;; Only continue when emacs or emacsclient is running in terminal.
  (unless (display-graphic-p)
    (send-to-terminal-twice "\e[5 q\e]12;#FFAF00\a")))

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-snippets disaster company-c-headers cmake-mode clang-format org-mime smeargle orgit magit-gitflow gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit magit-popup git-commit with-editor flycheck-pos-tip pos-tip flycheck yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode dash-functional cython-mode company-anaconda anaconda-mode pythonic vmd-mode mmm-mode markdown-toc markdown-mode gh-md org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-download htmlize gnuplot xclip xterm-color unfill shell-pop mwim multi-term fuzzy flyspell-correct-ivy flyspell-correct eshell-z eshell-prompt-extras esh-help company-statistics company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete monokai-theme ws-butler winum which-key wgrep volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline smex restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint ivy-hydra info+ indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-make google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump define-word counsel-projectile column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
