{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          python312
          python312Packages.virtualenv
          python312Packages.pandas
          python312Packages.requests
          python312Packages.numpy
          python312Packages.lightgbm
          python312Packages.optuna
          python312Packages.dask
          python312Packages.pyarrow
          python312Packages.dask-expr
          python312Packages.scikit-learn
          python312Packages.conda 
          python312Packages.pyopengl
          qt5.qtwebengine
          qt5.qtbase
          libGL
          libGLU
          fontconfig
          xorg.libX11
          xwayland
          wayland
          wayland-protocols
          mesa
        ];

        shellHook = ''
          export QT_QPA_PLATFORM=xcb
          export GDK_BACKEND=x11,wayland
        '';
      };
    });
}
