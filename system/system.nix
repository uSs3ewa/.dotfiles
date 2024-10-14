{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./network.nix
    ./software.nix
  ];

  system.stateVersion = "24.05";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "amdgpu.abmlevel=0" ];
    kernel.sysctl = {
      #  64 -- term, kill, oom-kill
      # 128 -- reboot and poweroff
      "kernel.sysrq" = 128 + 64;
    };
    plymouth.enable = true;

    loader = {
      timeout = 0;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };
  # Can be used for swap or general purpose RAM
  zramSwap.enable = true;
  # Customize kill process, alternative oom killer
  services.earlyoom = {
    enable = true;
    freeSwapThreshold = 20;
    reportInterval = 0;
    enableNotifications = true;
    extraArgs = [
      "--avoid plasmashell"
    ];
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  nix = {
      # garbage collection
      gc.automatic = true;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
      };
    };
  
  users.users.stoat = {
    isNormalUser = true;
    description = "stoat";
    home = "/home/stoat";
    createHome = true;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
