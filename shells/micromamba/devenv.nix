{ pkgs, config, ... }:

{
  env.MAMBA_ROOT_PREFIX = "${config.env.DEVENV_STATE}/micromamba";

  packages = [ pkgs.git pkgs.micromamba pkgs.file ];

  enterShell = ''
    micromamba --version
    set -h
    eval "$(micromamba shell hook --shell=bash)"
  '';
}
