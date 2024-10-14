{ ... }:

{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;

    config = {
      warn_timeout = "0s";
      hide_env_diff = true;
    };
  };
}
