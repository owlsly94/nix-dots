{
  description = "Owlsly's NixOS Flake - 25.11";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    zen-browser.url = "github:youwen5/zen-browser-flake";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix, zen-browser, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
    nixosConfigurations.OwlslyBox = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs-unstable; };
      modules = [
        ./configuration.nix
        stylix.nixosModules.stylix

        {
          nixpkgs.overlays = [
            (final: prev: {
              lutris = pkgs-unstable.lutris;
              vscode = pkgs-unstable.vscode;
              discord = pkgs-unstable.discord;
            })
          ];
        }

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.owlsly = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
        }
      ];
    };
  };
}
