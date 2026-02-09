{ pkgs, ... }:

{
  home.username = "owlsly";
  home.homeDirectory = "/home/owlsly";

  # Svi tvoji programi na jednom mestu
  home.packages = with pkgs; [
    # Terminal & CLI
    alacritty
    kitty
    btop
    fastfetch
    glow
    ranger
    neovim
    starship
    zsh
    
    # Browsers
    google-chrome
    firefox
    bitwarden-desktop
    
    # GUI Apps
    discord
    vscode
    obs-studio
    localsend
    jellyfin-media-player
    xfce.thunar
    
    # Hyprland Ecosystem
    waybar
    dunst
    rofi
    wlogout
    nwg-look
    pyprland
    faugus-launcher
    
    # Gaming & Dev
    lutris
    prismlauncher
    protonup-qt
    mangohud
    mpv
  ];

  # Starship i Zsh integracija
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = "eval \"$(starship init zsh)\"";
  };

  # Omogući fontove da bi ikone radile (važno za Waybar/Starship)
  fonts.fontconfig.enable = true;

  home.stateVersion = "25.11";
}
