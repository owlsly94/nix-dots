{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Terminals & Editors
    alacritty  # GPU-accelerated terminal
    kitty      # Feature-rich terminal with graphics support

    # Development
    vscode     # GUI code editor
    nodejs_24  # JavaScript runtime

    # System Utilities
    btop       # Resource monitor (prettier htop)
    fastfetch  # System info display
    glow       # Markdown renderer for the terminal
    ranger     # Terminal file manager
    tree       # Directory tree display

    # Graphics & Screenshot
    swww                # Wallpaper daemon for Wayland
    grim                # Screenshot tool for Wayland
    slurp               # Region selector for screenshots
    papirus-icon-theme  # Icon theme

    # Media & Creative
    mpv                         # Minimal video player
    ffmpeg                      # Audio/video processing toolkit
    hugo                        # Static site generator
    jellyfin-desktop            # Jellyfin desktop client
    kdePackages.kdenlive        # Non-linear video editor
    #audacity                    # Audio editor

    # Networking & Communication
    bitwarden-desktop  # Password manager
    discord            # Voice/text chat
    #telegram-desktop   # Messaging app
    localsend          # Local file sharing (AirDrop alternative)

    # Wayland & Desktop GUI
    waybar    # Customizable status bar
    rofi      # App launcher / menu
    wlogout   # Logout screen
    nwg-look  # GTK theme settings for Wayland
    pyprland  # Hyprland plugin system

    # Browsers
    firefox    # Mozilla browser
    #floorp-bin # Firefox fork with extra customisation

    # Additional Tools
    megatools  # MEGA cloud storage CLI

    # Flake inputs
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default  # Zen browser
  ];
}
