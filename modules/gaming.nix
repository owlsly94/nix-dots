{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Launchers
    lutris
    prismlauncher
    faugus-launcher
    
    # Compatibility & Tools
    protonup-qt
    mangohud
    goverlay
    vkbasalt
  ];
}
