{
  description = "Owlsly's NixOS Flake - 25.11";

  inputs = {
    # Glavni NixOS repozitorijum (verzija 25.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager (mora da prati istu verziju)
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Opciono: Zen Browser (ako ga nema u zvaničnom nixpkgs, često se dodaje ovako)
    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations.OwlslyBox = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # Putanja do tvoje sistemske konfiguracije
        ./configuration.nix

        # Povezivanje Home Managera sa sistemom
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.owlsly = import ./home.nix;

          # Dozvoli unfree pakete unutar Home Managera (Discord, Chrome, itd.)
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
