{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Package managers & versioning
    wget
    git

    # System utilities
    pavucontrol       # Audio volume control GUI
    mangohud          # In-game performance overlay
    unzip             # Archive extraction
    udiskie           # Auto-mount USB devices (tray applet)
    htop              # Interactive process viewer
    tree              # Directory tree display
    lm_sensors        # Hardware monitoring tools

    # Development & graphics
    glfw              # OpenGL/Vulkan window context library
    ffmpegthumbnailer # Video thumbnail generation for file managers
  ];
}
