{
  description = "Owlsly's NixOS Flake - 25.11";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, stylix, zen-browser, ... }@inputs:
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
        { nixpkgs.config.allowUnfree = true; }
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
          home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable nixvim; };
        }
      ];
    };
  };
}
