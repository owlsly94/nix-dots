{ pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.nixvim.homeModules.nixvim
    ./modules/home/nixvim.nix
    ./modules/home/theme.nix
    ./modules/home/zsh.nix
    ./modules/home/starship.nix
    ./modules/home/kitty.nix
    ./modules/home/alacritty.nix
    ./modules/home/git.nix
    ./modules/home/gaming.nix
    ./modules/home/mangohud.nix
    ./modules/home/dunst.nix
    ./modules/home/fastfetch.nix
    ./modules/home/obs.nix
    ./modules/home/mpv.nix
    ./modules/home/chrome-browser.nix
    ./modules/home/hyprland.nix
    ./modules/home/pyprland.nix
    ./modules/home/hyprlock.nix
    ./modules/home/waybar.nix
    ./modules/home/wallpaper.nix
    ./modules/home/rofi.nix
    ./modules/home/applications.nix
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
