{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Game Launchers
    (lutris.override {
      extraPkgs = pkgs: with pkgs; [
        # Wine packages (updated naming)
        wineWow64Packages.stable
        wineWow64Packages.staging
        winetricks
    
        # 32-bit libraries (critical for Wine games)
        pkgsi686Linux.libGL
        pkgsi686Linux.libpulseaudio
        pkgsi686Linux.libva
        pkgsi686Linux.vulkan-loader
        pkgsi686Linux.mesa
    
        # Common dependencies
        vulkan-tools
        vulkan-loader
        libpulseaudio
        libGL
        libva
        openssl
        gnutls
        libgpg-error
      ];
    })

    prismlauncher       # Minecraft launcher with mod support
    faugus-launcher     # Lightweight launcher
    
    # Compatibility & Performance Tools
    protonup-qt         # GUI for managing Proton versions
    mangohud            # Performance overlay for games
    goverlay            # GUI for MangoHud configuration
    vkbasalt            # Vulkan post-processing layer
  ];
}
