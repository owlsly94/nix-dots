{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      # BACKGROUND
      background = [
        {
          monitor = "";
          path = "/home/owlsly/.config/wallpapers/jinx04.jpg";
          blur_passes = 2;
          contrast = 0.9;
          brightness = 0.5;
          vibrancy = 0.17;
          vibrancy_darkness = 0;
        }
      ];

      # GENERAL
      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = true;
      };

      # INPUT FIELD
      "input-field" = [
        {
          monitor = "";
          size = "300, 40";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(53, 52, 77, 0.5)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "Syne";
          placeholder_text = "";
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];

      # LABELS (Time and Date)
      label = [
        # Hour
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%H\")\"";
          color = "rgba(146, 140, 255, 1)";
          font_family = "JetBrainsMono Nerd Font Bold";
          font_size = 180;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # Minute
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%M\")\"";
          color = "rgba(255, 255, 255, 1)";
          font_family = "JetBrainsMono Nerd Font Bold";
          font_size = 180;
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span color='##ffffff00'>$(date '+%A, ')</span><span color='##928cff00'>$(date '+%d %B')</span>\"";
          font_size = 30;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
