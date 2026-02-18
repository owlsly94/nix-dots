{ pkgs, lib, ... }:

{
  programs.mangohud = {
    enable = true;
    settings = lib.mkForce {
      # Performance Monitoring
      cpu_temp = true;
      cpu_stats = true;
      gpu_temp = true;
      gpu_stats = true;
      ram = true;
      fps = true;
      frame_timing = true;

      # Overlay Appearance
      position = "top-left";
      font_size = 24;
      
      # Transparency & Colors
      background_alpha = 0.0;
      alpha = 0.8;
      text_color = "ffffff";
    };
  };
}
