{ pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.nixvim.homeModules.nixvim
    ./modules/nixvim.nix
    ./modules/theme.nix
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/kitty.nix
    ./modules/alacritty.nix
    ./modules/git.nix
    ./modules/gaming.nix
    ./modules/mangohud.nix
    ./modules/dunst.nix
    ./modules/fastfetch.nix
    ./modules/obs.nix
    ./modules/mpv.nix
    ./modules/chrome-browser.nix
    ./modules/hyprland.nix
    ./modules/pyprland.nix
    ./modules/hyprlock.nix
    ./modules/waybar.nix
    ./modules/wallpaper.nix
    ./modules/rofi.nix
    ./modules/applications.nix
  ];

  home.username = "owlsly";
  home.homeDirectory = "/home/owlsly";

  xdg.enable = true;

  xdg.configFile = {
    "wallpapers".source = ./config/wallpapers;
    "wlogout".source = ./config/wlogout;
  };
  
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.11";
}
