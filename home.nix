{ pkgs, ... }:

{
  imports = [
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/git.nix
    ./modules/gaming.nix
    ./modules/dunst.nix
    ./modules/obs.nix
    ./modules/chrome-browser.nix
  ];

  home.username = "owlsly";
  home.homeDirectory = "/home/owlsly";

  home.packages = with pkgs; [
    # Terminal & CLI
    alacritty
    kitty
    btop
    fastfetch
    glow
    ranger
    neovim
    nerd-fonts.jetbrains-mono
    swww
    bibata-cursors
    tokyonight-gtk-theme
    papirus-icon-theme
    
    # Browsers
    firefox
    bitwarden-desktop
        
    # GUI Apps
    discord
    vscode
    localsend
    jellyfin-media-player
    xfce.thunar
    nodejs_24
    mpv
    megatools
    
    # Hyprland Ecosystem
    waybar
    rofi
    wlogout
    nwg-look
    pyprland
  ];

  fonts.fontconfig.enable = true;
  home.stateVersion = "25.11";
}
