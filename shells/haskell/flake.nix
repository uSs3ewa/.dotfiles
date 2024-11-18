{
  inputs = {
    # Import Nixpkgs and Flake Utils for multi-system support
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    # Use flake-utils to support multiple systems (e.g., Linux, macOS)
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };

      # Configure Haskell Language Server (HLS) with specific GHC versions
      hls = pkgs.haskell-language-server.override {
        supportedGhcVersions = [ "98" ];
      };
    in {
      # Define the development shell
      devShells.default = pkgs.mkShell {
        buildInputs = [
          # Core Haskell tools
          pkgs.haskell.compiler.ghc964  # Use GHC 9.6.4 (or replace with your desired version)
          pkgs.cabal-install            # Cabal for managing Haskell packages
          pkgs.stack                    # Stack for Haskell project management

          # Development tools
          hls                           # Haskell Language Server
        ];

        # Optional environment variables
        shellHook = ''
          echo "Welcome to the Haskell development environment!"
          echo "Using GHC: $(ghc --version)"
        '';
      };
    });
}

