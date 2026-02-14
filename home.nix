{ pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
    
    ./modules/theme.nix
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/kitty.nix
    ./modules/git.nix
    ./modules/gaming.nix
    ./modules/dunst.nix
    ./modules/obs.nix
    ./modules/chrome-browser.nix
    ./modules/hyprland.nix
    ./modules/pyprland.nix
    ./modules/hyprlock.nix
    ./modules/waybar.nix
    ./modules/wallpaper.nix
    ./modules/rofi.nix
  ];

  home.username = "owlsly";
  home.homeDirectory = "/home/owlsly";

  xdg.enable = true;

  xdg.configFile = {
    "alacritty".source = ./config/alacritty;
    "MangoHud".source = ./config/MangoHud;
    "mpv".source = ./config/mpv;
    "nvim".source = ./config/nvim;
    "wallpapers".source = ./config/wallpapers;
    "wlogout".source = ./config/wlogout;
    "fastfetch".source = ./config/fastfetch;
  };

  home.packages = with pkgs; [
    alacritty
    kitty
    btop
    fastfetch
    glow
    ranger
    neovim
    swww
    hugo
    ffmpeg
    firefox
    floorp-bin
    bitwarden-desktop
    discord
    vscode
    localsend
    jellyfin-media-player
    nodejs_24
    mpv
    kdePackages.kdenlive
    megatools
    grim
    slurp
    waybar
    rofi
    wlogout
    nwg-look
    pyprland
    papirus-icon-theme
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.11";
}
