{ pkgs, lib, ... }:
{
  imports = [
    ./software/alacritty.nix
    ./software/bash.nix
    ./software/direnv.nix
    ./software/gpg.nix
    #./software/neovim.nix
    ./software/tmux.nix
    #./software/fish.nix or shell.nix
    ];

  programs = {
    home-manager.enable = true;
    firefox.enable = true;
  };
  
  # utils
  home.packages = with pkgs; [
    # statistics of code
    tokei
    # rust implementation
    wl-clipboard-rs
    # for ssh
    authenticator
    fastfetch
    fzf
    zoxide
    zellij
    eza
    bat
    fd
    tree
    usbutils
    killall
    usb-blaster-udev-rules
    wlr-randr # `xrandr` for wayland
    nh
    zip
    unzip
    ripgrep
    git
    jdk22
    libclang
    #python3
    (python3.withPackages(ps: with ps; [ pandas requests pyarrow ]))
    stylua
    lua-language-server
    tmuxifier
    rcm
    onlyoffice-bin
    kaggle
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "quartus-prime-lite"
    "obsidian"
  ];
}
