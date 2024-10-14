{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    extraConfig = ''
	    unbind C-b
	    set -g prefix C-Space
	    bind C-Space send-prefix

      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'aserowy/tmux.nvim'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
    
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      
      bind-key c new-window -c "#{pane_current_path}"
      bind-key % split-window -h -c "#{pane_current_path}"
      bind-key '"' split-window -v -c "#{pane_current_path}"

      bind C-h select-pane -L
      bind C-j select-pane -D
      bind- C-k select-pane -U
      bind C-l select-pane -R

      set -g status-keys vi
      set -g mode-keys   vi
    '';

    plugins = [
      pkgs.tmuxPlugins.gruvbox

      { plugin = pkgs.tmuxPlugins.battery;
        extraConfig = ''
          set -as terminal-features ",alacritty*:RGB"
          set-option -g @batt_remain_short true
          set-option -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #{battery_percentage}  #{battery_remain} "
        ''; }
    ];
  };
}
