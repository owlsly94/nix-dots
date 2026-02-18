{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ../wallpaper.png; 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
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

    targets = {
      dunst.enable = false;
      hyprlock.enable = false;
      hyprland.enable = false;
      waybar.enable = false;
      kitty.enable = true;
      alacritty.enable = false;
      gtk.enable = true;
      nixvim.enable = false;
    };
  };
}
