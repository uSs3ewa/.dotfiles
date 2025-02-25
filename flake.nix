{
  description = "Main NixOS Flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    swww.url = "github:LGFae/swww";
    nix-colors.url = "github:misterio77/nix-colors";
    
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, nixpkgs-unstable, nixos-generators, home-manager, hyprland, hyprpaper, swww, nix-colors, nix-ld, ... }:
    let
      lib = nixpkgs.lib;
      username = "stoat";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      
      # Development Shell
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [ ];
      };

      # Templates
      templates = {
        python = {
          path = ./shells/python;
          description = "A Python dev shell";
        };
        haskell = {
          path = ./shells/haskell;
          description = "A Haskell dev shell";
        };
      };

      # NixOS Configuration
      nixosConfigurations = {
        stoat = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
            ./system/hardware.nix
            ./system/network.nix
            ./system/software.nix
            ./system/system.nix
            nix-ld.nixosModules.nix-ld
            { programs.nix-ld.dev.enable = true; }
          ];
        };
      };

      # Home Manager Configuration
      homeConfigurations = {
        stoat = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            inherit inputs;
          };
          modules = [
            ./home/home.nix 
          ];
        };
      };

    };
}

