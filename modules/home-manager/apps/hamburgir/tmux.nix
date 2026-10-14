{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        inputs,
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "tmux" {
            name = "tmux";
            description = "tmux, a terminal multiplexer";
            settings = {
              extraConfig = ''
                set -g allow-passthrough on

                # Tokyo Night rounded theme
                set -g status-position top
                set -g status-style "fg=#c0caf5,bg=#1a1b26"
                set -g status-justify centre

                set -g status-left-length 100
                set -g status-left "#[fg=#7aa2f7,bg=#1a1b26] #[fg=#1a1b26,bg=#7aa2f7,bold]  #S #[fg=#7aa2f7,bg=#1a1b26]"

                set -g status-right-length 150
                set -g status-right "#[fg=#bb9af7,bg=#1a1b26]#[fg=#1a1b26,bg=#bb9af7,bold]  #{b:pane_current_path} #[fg=#bb9af7,bg=#1a1b26] #[fg=#e0af68,bg=#1a1b26]#[fg=#1a1b26,bg=#e0af68,bold] #{battery_icon} #{battery_percentage} #[fg=#e0af68,bg=#1a1b26] #( [ -f ~/.ai_status ] && echo \"#[fg=#9ece6a,bg=#1a1b26]#[fg=#1a1b26,bg=#9ece6a,bold] 🤖 \$(cat ~/.ai_status) #[fg=#9ece6a,bg=#1a1b26]\" ) "

                setw -g window-status-style "fg=#414868,bg=#1a1b26"
                setw -g window-status-format "#[fg=#414868,bg=#1a1b26]#[fg=#c0caf5,bg=#414868] #I:#P | #W #[fg=#414868,bg=#1a1b26]"
                setw -g window-status-current-style "fg=#9ece6a,bg=#1a1b26,bold"
                setw -g window-status-current-format "#[fg=#9ece6a,bg=#1a1b26]#[fg=#1a1b26,bg=#9ece6a,bold] #I:#P | #W #[fg=#9ece6a,bg=#1a1b26]"
                set -g window-status-separator " "

                set -g pane-border-style "fg=#7aa2f7"
                set -g pane-active-border-style "fg=#7aa2f7"

                # --- Additional Keybindings ---
                # Navigate panes with HJKL
                bind h select-pane -L
                bind j select-pane -D
                bind k select-pane -U
                bind l select-pane -R

                # Last client (default L is resize-pane -R with customPaneNavigationAndResize)
                bind g switch-client -l

                # Synchronize panes (toggle)
                bind S set-window-option synchronize-panes\; display-message "synchronize-panes #{?pane_synchronized,on,off}"

                # Fast window jumping (Alt+1 to Alt+9)
                bind -n M-1 select-window -t 1
                bind -n M-2 select-window -t 2
                bind -n M-3 select-window -t 3
                bind -n M-4 select-window -t 4
                bind -n M-5 select-window -t 5
                bind -n M-6 select-window -t 6
                bind -n M-7 select-window -t 7
                bind -n M-8 select-window -t 8
                bind -n M-9 select-window -t 9

                # Sessionizer & Jumper
                bind f run-shell "tmux neww ${inputs.scripts.packages.${pkgs.system}.tmux-sessionizer}/bin/tmux-sessionizer"
                bind F run-shell "${inputs.scripts.packages.${pkgs.system}.tmux-session-clear}/bin/tmux-session-clear"
                bind Tab display-popup -E "${inputs.scripts.packages.${pkgs.system}.tmux-session-jumper}/bin/tmux-session-jumper"

                # Floating Scratchpad (Alt+g)
                bind -n M-g display-popup -E "tmux new-session -A -s scratch"

                # Reload config (Note: ~/.tmux.conf is usually a symlink to the generated config by Home Manager)
                bind r source-file ~/.config/tmux/tmux.conf\; display-message "Tmux config reloaded!"
              '';
              aggressiveResize = true;
              baseIndex = 1;
              disableConfirmationPrompt = true;
              escapeTime = 0;
              historyLimit = 5000;
              keyMode = "vi";
              mouse = true;
              # newSession = true;
              plugins = with pkgs; [
                tmuxPlugins.cpu
                tmuxPlugins.battery
              ];
              customPaneNavigationAndResize = true;
              resizeAmount = 1;
              # sensibleOnTop = false;
              shortcut = "Space";
              secureSocket = false;
              terminal = "screen-256color";
              tmuxp.enable = true;
            };
          })
        ];

        config.desktop.apps.tmux.enable = lib.mkDefault true;
      }
    )
  ];
}
