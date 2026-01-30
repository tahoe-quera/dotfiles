{
  description = "Home Manager configuration of pooralaska";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    home-manager,
    fenix,
    nix-darwin,
    ...
  }: {
    # Mac config with nix-darwin + home-manager
    darwinConfigurations = {
      macmini = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ({pkgs, ...}: {
            nix.package = pkgs.nixVersions.latest;
            system.stateVersion = 6;
            nixpkgs.overlays = [fenix.overlays.default];
            users.users.pooralaska = {
              home = "/Users/pooralaska";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.pooralaska = {
              imports = [./hosts/macmini.nix ./modules];
            };
          })
        ];
      };
      quera = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ({pkgs, ...}: {
            nix.package = pkgs.nixVersions.latest;
            system.stateVersion = 6;
            users.users.tahoeschrader = {
              home = "/Users/tahoeschrader";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tahoeschrader = {
              imports = [./hosts/quera.nix ./quera-modules];
            };
          })
        ];
      };
    };

    # Linux standalone Home Manager configs
    homeConfigurations = {
      turingpi = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [fenix.overlays.default];
        };
        modules = [
          ({pkgs, ...}: {
            nix.package = pkgs.nixVersions.latest;
            home.username = "tahoe";
            home.homeDirectory = "/home/tahoe";
          })
          ./hosts/turingpi.nix
          ./modules
        ];
      };
      salaryman = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [
          ({pkgs, ...}: {
            nix.package = pkgs.nixVersions.latest;
            home.username = "pooralaska";
            home.homeDirectory = "/home/pooralaska";
          })
          ./hosts/salaryman.nix
          ./quera-modules
        ];
      };
      thinkcentre = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        modules = [
          ({pkgs, ...}: {
            nix.package = pkgs.nixVersions.latest;
            home.username = "pooralaska";
            home.homeDirectory = "/home/pooralaska";
          })
          ./hosts/thinkcentre.nix
          ./control-modules
        ];
      };
    };
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
