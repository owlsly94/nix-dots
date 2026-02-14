{ pkgs, ... }:

let
  myChrome = pkgs.google-chrome.override {
    commandLineArgs = [
      # Wayland & Performance
      "--ozone-platform-hint=auto"
      "--enable-features=WaylandWindowDecorations"
      
      # Hardware Acceleration
      "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,CanvasOopRasterization"
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      
      # Vulkan
      "--enable-vulkan"
      "--enable-vulkan-from-angle"
      "--use-gl=angle"
      "--use-angle=vulkan"
    ];
  };
in
{
  home.packages = [
    myChrome
  ];
}
