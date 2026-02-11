{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = "${config.stylix.image}";
          blur_passes = 2;
          contrast = 0.9;
          brightness = 0.5;
          vibrancy = 0.17;
          vibrancy_darkness = 0;
        }
      ];

      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = true;
      };

      "input-field" = [
        {
          monitor = "";
          size = "300, 40";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(${c.base01-rgb-r}, ${c.base01-rgb-g}, ${c.base01-rgb-b}, 0.5)";
          font_color = "rgb(${c.base05-rgb-r}, ${c.base05-rgb-g}, ${c.base05-rgb-b})";
          fade_on_empty = false;
          font_family = "JetBrainsMono Nerd Font";
          placeholder_text = "";
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%H\")\"";
          color = "rgb(${c.base0E-rgb-r}, ${c.base0E-rgb-g}, ${c.base0E-rgb-b})"; # base0E (Magenta/Purple)
          font_family = "JetBrainsMono Nerd Font Bold";
          font_size = 180;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%M\")\"";
          color = "rgb(${c.base05-rgb-r}, ${c.base05-rgb-g}, ${c.base05-rgb-b})"; # base05 (Foreground/White)
          font_family = "JetBrainsMono Nerd Font Bold";
          font_size = 180;
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span color='#${c.base05}'>$(date '+%A, ')</span><span color='#${c.base0E}'>$(date '+%d %B')</span>\"";
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
