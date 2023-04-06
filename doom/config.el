;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Daniel Pinkston"
      user-mail-address "earlgreytea42@outlook.com")

(setq doom-font(font-spec :family "Iosevka" :size 20)
      doom-big-font(font-spec :family "Iosevka" :size 30)
      doom-variable-pitch-font (font-spec :family "Roboto" :style "Regular" :size 12 :weight 'regular))

;; sets the cursor to always be a block
;;(setq evil-insert-state-cursor 'box)

;; make the cursor blinking
(blink-cursor-mode 1)

;; relative line numbers
(setq display-line-numbers-type `relative)

(setq doom-theme 'doom-gruvbox)

(setq org-directory "~/Notes/Org/")
(add-hook 'after-save-hook 'org-babel-tangle)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

(after! org-agenda
    (setq org-agenda-files (list "~/Notes/Org-Roam/20230202115352-agenda.org"
                                 "~/Notes/Org-Roam/20230202114927-todo.org")))

(setq org-roam-directory "~/Notes/Org-Roam/")
(setq org-roam-db-autosync t)
(require 'org-roam-export)

(setq org-roam-capture-templates
    '(("d" "default" plain
          "\n* Tags: \n%? \n\n"
          :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
          :unnarrowed t)
      ("n" "notes" plain
          "\n* Tags: \n%? \n\n* ${title} \n"
          :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
          :unnarrowed t)
      ("s" "snapshot" plain
          (file "~/Notes/Org/snapshot_template.org")
          :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
          :unnarrowed t)
      ("i" "idea" plain
          "\n* Tags: \n%? \n\n"
          :if-new (file+head "Ideas/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
          :unnarrowed t)))

(setq org-roam-dailies-directory "Journal/")
(setq org-roam-dailies-capture-templates
      '(("d" "default" plain
        "\n* Tags: \n%? \n\n"
        :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")
        :unnarrowed t)
      ("s" "standup" plain
         (file "~/Notes/Org/standup_template.org")
         :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")
         :unnarrowed t)
      ("r" "reflection" plain
          "\n* Tags: \n%? \n\n"
          :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
;; (add-hook! '+doom-dashboard-functions :append
;; (setq fancy-splash-image (concat doom-user-dir "shinjiicon.jpeg")))

(after! doom-modeline
  (setq doom-modeline-enable-word-count t
        doom-modeline-header-line nil
        ;doom-modeline-hud nil
        doom-themes-padded-modeline t))
(add-hook! 'doom-modeline-mode-hook
           (progn
  (set-face-attribute 'header-line nil
                      :background (face-background 'mode-line)
                      :foreground (face-foreground 'mode-line))
  ))

(setq treemacs-width 25)

(map! :leader
      :desc "Dired jump" "pv" #'dired-jump)

(map! :leader
      :desc "Find file" "pf" #'dired)

(map! :leader
      :desc "Open doom dashboard" "oh" #'+doom-dashboard/open)

(map! :leader
      :desc "Open calendar" "oc" #'calendar)

(map! :leader
      :desc "Open emms" "oe" #'emms)

(map! :leader
      :desc "Load a file into emms" "lf" #'emms-add-file)

(map! :leader
      :desc "Load a directory into emms" "ld" #'emms-add-directory)

(map! :leader
      :desc "Find a org roam node" "nrf" #'org-roam-node-find)

(map! :leader
      :desc "Find a org roam node" "nrf" #'org-roam-node-insert)

(map! :leader
      :desc "Open org roam ui" "ou" #'org-roam-ui-open)
