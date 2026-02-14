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
    "wallpapers".source = ./config/wallpapers;
    "wlogout".source = ./config/wlogout;
    "fastfetch".source = ./config/fastfetch;
  };

  fonts.fontconfig.enable = true;

  # Home packages - organized by category for maintainability
  home.packages = with pkgs; [
    # Terminals & Development
    alacritty
    kitty
    neovim
    vscode
    nodejs_24

    # System Utilities
    btop
    fastfetch
    glow
    ranger
    tree

    # Graphics & Screenshot Tools
    swww
    grim
    slurp
    papirus-icon-theme

    # Media & Entertainment
    mpv
    ffmpeg
    hugo
    jellyfin-media-player
    kdePackages.kdenlive

    # Networking & Communication
    bitwarden-desktop
    discord
    localsend

    # Wayland & GUI Tools
    waybar
    rofi
    wlogout
    nwg-look
    pyprland

    # Additional Tools
    megatools
    firefox
    floorp-bin
  ];

  home.stateVersion = "25.11";
}
