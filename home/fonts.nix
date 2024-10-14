{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    jetbrains-mono
    font-awesome
    powerline-fonts
    powerline-symbols
  ];
}
