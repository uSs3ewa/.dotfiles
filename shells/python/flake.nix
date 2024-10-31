{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells."x86_64-linux".default = pkgs.mkShell {
        buildInputs = [
          pkgs.python312
          pkgs.python312Packages.pandas
          pkgs.python312Packages.requests
          pkgs.python312Packages.numpy
          pkgs.python312Packages.lightgbm
          pkgs.python312Packages.optuna
          pkgs.python312Packages.dask
        ];
      };
    });
}
