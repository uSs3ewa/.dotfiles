{ config, pkgs, inputs, ... }:

{
  imports = [
      ./backup.nix
      ./fonts.nix
      ./software.nix 
      ];
  
  home = {
    username = "stoat";
    homeDirectory = "/home/stoat";
    sessionVariables = {
      EDITOR = "nvim";
      TERM = "fish";
    };
    # design
    packages = with pkgs; [
      iosevka
      (pkgs.nerdfonts.override { fonts = [ "Hack" "Iosevka" "FiraCode" ]; })
      # wayland setup in future
      wofi
      waybar
      hyprpaper # Background image
      hyprpicker # Pick color from screen
      mako
      libnotify
      swww
      networkmanagerapplet
      brightnessctl
      wlogout
      hyprlock
      hyprshot
      ranger
    ];
    file = {
    	".config/nixpkgs/config.nix".text = ''
    	      { allowUnfree = true; }
    	'';

    	# # Building this configuration will create a copy of 'dotfiles/screenrc' in
    	# # the Nix store. Activating the configuration will then make '~/.screenrc' a
    	# # symlink to the Nix store copy.
    	# ".screenrc".source = dotfiles/screenrc;
    	
    	# # You can also set the file content immediately.
    	# ".gradle/gradle.properties".text = ''
    	#   org.gradle.console=verbose
    	#   org.gradle.daemon.idletimeout=3600000
    	# '';
    }; # end file

    stateVersion = "24.05";
  };

  systemd.user.tmpfiles.rules = [
  	  "d %h/Downloads - - - 5d -"
  ];
  
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/stoat/etc/profile.d/hm-session-vars.sh
  #
}
