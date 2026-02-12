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
    firefox
    floorp-bin
    bitwarden-desktop
    discord
    vscode
    localsend
    jellyfin-media-player
    nodejs_24
    mpv
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
