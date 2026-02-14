{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Game Launchers
    lutris              # Universal game launcher with Proton support
    prismlauncher       # Minecraft launcher with mod support
    faugus-launcher     # Lightweight launcher
    
    # Compatibility & Performance Tools
    protonup-qt         # GUI for managing Proton versions
    mangohud            # Performance overlay for games
    goverlay            # GUI for MangoHud configuration
    vkbasalt            # Vulkan post-processing layer
  ];
}
