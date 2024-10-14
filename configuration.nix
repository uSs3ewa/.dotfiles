{ 
  config,
  lib,
  pkgs,
  inputs,
  pkgs-unstable,
  # pkgs-fd40cef8d,
  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];  

   #home-manager = {
    #extraSpecialArgs = { inherit inputs; };
    #users = {
	   #stoat = import ./home/home.nix;
    #};
   #};
    programs.fish.enable = true;
    environment.shells = with pkgs; [ fish ];
    users.defaultUserShell = pkgs.fish;
    programs.neovim = {  
      enable = true;
      package = pkgs-unstable.neovim-unwrapped;
      vimAlias = true;
    }; 
    programs.hyprland.enable = true; 
   
  console.useXkbConfig = true;
  
  services.udev.extraRules = ''
      # USB-Blaster
      SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="0666"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6002", MODE="0666"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6003", MODE="0666"
      
      # USB-Blaster II
      SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="0666"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="0666"
    '';

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;

    mouse = {
	# accelProfile = "flat";
	# accelSpeed = "-0.32";	   
    };

    touchpad = {
	naturalScrolling = true;
	# accelProfile = "flat";
    };
  };

  # SSH
  services.openssh.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  system.stateVersion = "24.05";

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # networking.interfaces.eth0.ipv4.addresses = [ {
  #	address = "192.168.1.2";
  #	prefixLength = 24;
  #  } ];
  # networking.defaultGateway = "192.168.1.1";
  # networking.nameservers = [ "8.8.8.8" ];
}

