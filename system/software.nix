{ pkgs, lib, ... }:

{
  # todo: Wayland-only
  services.xserver = {
    enable = true;
    xkb = {
    	layout = "us, ru";
    	options = "grp:alt_shift_toggle";
    	#xkbmodel = "microsoft";
    	#xkbVariant = "winkeys";
    	#displayManager.gdm.enable = true;
    	#displayManager.gdm.wayland = true;
    };
    excludePackages = with pkgs; with xorg; [
      xrandr
      xrdb
      xlsclients
      xset
      xsetroot
      xinput
      xprop
      xauth
      xterm
    ];
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  # greetd display manager
  /*services.greetd =
  let session = {
    command = "Hyprland --config /etc/greetd/hyprland.conf";
    user = "stoat";
  };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };
  */
  # unlock GPG keyring on login
  # security.pam.services.greetd.enableGnomeKeyring = true;
  # programs.regreet.enable = true;


  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect = {
    enable = true;
    package = lib.mkForce pkgs.kdePackages.kdeconnect-kde;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      elisa
      gwenview
      okular
      kate
      khelpcenter
      print-manager
  ];

  # main programs
  environment.systemPackages = with pkgs; [
    # neovim
    micro
    wget
    firefox-wayland
    home-manager
    quartus-prime-lite
    obsidian
  ];

  services.fwupd.enable = true;
  programs = {
    iotop.enable = true;
    htop.enable = true;
    nano.enable = false;
    neovim = {
      enable = true;
      withRuby = false;
      withPython3 = false;
    };

    partition-manager.enable = true;
  };

  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
   };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
	  "quartus-prime-lite"
	  "obsidian"
    ];
}
