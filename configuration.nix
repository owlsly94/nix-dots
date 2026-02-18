{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system-services.nix
    ./modules/system-packages.nix
    ./modules/boot.nix
    ./modules/network.nix
    ./modules/drivers.nix
    ./modules/desktop.nix
    ./modules/users.nix
    ./modules/gamemode.nix
    ./modules/nix-settings.nix
  ];

  system.stateVersion = "25.11"; #Do NOT change
}
