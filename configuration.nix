{ config, pkgs, ... }:

{
  imports = [
    ./hosts/hardware-configuration.nix
    ./modules/system/system-services.nix
    ./modules/system/system-packages.nix
    ./modules/system/boot.nix
    ./modules/system/network.nix
    ./modules/system/drivers.nix
    ./modules/system/desktop.nix
    ./modules/system/users.nix
    ./modules/system/gamemode.nix
    ./modules/system/nix-settings.nix
  ];

  system.stateVersion = "25.11"; #Do NOT change
}
