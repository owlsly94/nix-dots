{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ../wallpaper.png; 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";
    
    enableReleaseChecks = false;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      
      sizes = {
        applications = 13;
        terminal = 13;
        desktop = 12;
      };
    };

    targets.dunst.enable = false;
    targets.hyprlock.enable = false;
    targets.hyprland.enable = true;
    targets.waybar.enable = false;
    targets.kitty.enable = true;
    targets.gtk.enable = true;
  };
}
