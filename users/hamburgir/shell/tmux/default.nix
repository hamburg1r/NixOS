{ pkgs, ... }:

{
  programs.tmux = {
    extraConfig = ''
      set -g allow-passthrough on

      # Tokyo Night theme
      set -g status-style "fg=#c0caf5,bg=#1a1b26" # Foreground, background
      set -g status-left-length 40
      set -g status-left "#[fg=#7aa2f7,bg=#1a1b26] #S #[fg=#1a1b26,bg=#7aa2f7,nobold,nounderscore,noitalics]#[fg=#c0caf5,bg=#7aa2f7] #I:#P #[fg=#7aa2f7,bg=#1a1b26,nobold,nounderscore,noitalics]"
      set -g status-right-length 150
      set -g status-right "#[fg=#1a1b26,bg=#1a1b26,nobold,nounderscore,noitalics]#[fg=#c0caf5,bg=#1a1b26] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#1a1b26,nobold,nounderscore,noitalics]#[fg=#c0caf5,bg=#7aa2f7,bold] #(tmux-cpu) #[fg=#1a1b26,bg=#7aa2f7,nobold,nounderscore,noitalics]#[fg=#c0caf5,bg=#1a1b26] #(tmux-continuum) "

      setw -g window-status-style "fg=#c0caf5,bg=#1a1b26"
      setw -g window-status-current-style "fg=#7aa2f7,bg=#1a1b26,bold"
      setw -g window-status-current-format "#[fg=#1a1b26,bg=#7aa2f7,nobold,nounderscore,noitalics]#[fg=#c0caf5,bg=#7aa2f7] #I  #W #[fg=#7aa2f7,bg=#1a1b26,nobold,nounderscore,noitalics]"
      setw -g window-status-format "#[fg=#1a1b26,bg=#1a1b26,nobold,nounderscore,noitalics]#[fg=#c0caf5,bg=#1a1b26] #I  #W #[fg=#1a1b26,bg=#1a1b26,nobold,nounderscore,noitalics]"

      set -g pane-border-style "fg=#7aa2f7"
      set -g pane-active-border-style "fg=#7aa2f7"

      # --- Additional Keybindings ---
      # Split panes with current path
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      # Navigate panes with HJKL
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Synchronize panes (toggle)
      bind S set-window-option synchronize-panes\; display-message "synchronize-panes #{?pane_synchronized,on,off}"

      # Reload config (Note: ~/.tmux.conf is usually a symlink to the generated config by Home Manager)
      bind r source-file ~/.tmux.conf\; display-message "Tmux config reloaded!"
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
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    customPaneNavigationAndResize = true;
    resizeAmount = 1;
    # sensibleOnTop = false;
    shortcut = "Space";
    secureSocket = false;
    terminal = "screen-256color";
    tmuxp.enable = true;
  };
}
