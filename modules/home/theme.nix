{ pkgs, ... }:

let
  currentTheme = import ./current-theme.nix;
in
{
  stylix = {
    enable = true;
    image = ../../wallpaper.png; 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${currentTheme}.yaml";
    polarity = "dark";
    
    enableReleaseChecks = false;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.inter; 
        name = "Inter";
      };
      serif = {
        package = pkgs.iosevka;
        name = "Iosevka Etoile";
      };
      sizes = {
        applications = 13;
        terminal = 13;
        desktop = 12;
      };
    };
    targets = {
      dunst.enable = false;
      hyprlock.enable = false;
      hyprland.enable = false;
      waybar.enable = false;
      kitty.enable = true;
      #ghostty.enable = false;
      alacritty.enable = false;
      gtk.enable = true;
      nixvim.enable = false;
    };
  };
}
