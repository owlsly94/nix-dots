{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      general.live_config_reload = true;

      window = {
        title = "Alacritty";
        blur = true;
        opacity = 0.8;
        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };
        padding = {
          x = 5;
          y = 5;
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        size = 12.7;
        normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
        bold = { family = "JetBrainsMono Nerd Font"; style = "Bold"; };
        italic = { family = "JetBrainsMono Nerd Font"; style = "Italic"; };
        bold_italic = { family = "JetBrainsMono Nerd Font"; style = "Bold Italic"; };
      };

      terminal.shell.program = "zsh";

      colors = {
        draw_bold_text_with_bright_colors = true;
        
        primary = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          bright_foreground = "#CDD6F4";
          dim_foreground = "#CDD6F4";
        };

        cursor = {
          cursor = "#F5E0DC";
          text = "#1E1E2E";
        };

        vi_mode_cursor = {
          cursor = "#B4BEFE";
          text = "#1E1E2E";
        };

        selection = {
          background = "#F5E0DC";
          text = "#1E1E2E";
        };

        search = {
          focused_match = { background = "#A6E3A1"; foreground = "#1E1E2E"; };
          matches = { background = "#A6ADC8"; foreground = "#1E1E2E"; };
        };

        footer_bar = { background = "#A6ADC8"; foreground = "#1E1E2E"; };
        hints.start = { background = "#F9E2AF"; foreground = "#1E1E2E"; };
        hints.end = { background = "#A6ADC8"; foreground = "#1E1E2E"; };

        normal = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };

        bright = {
          black = "#585B70";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#A6ADC8";
        };

        dim = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };

        indexed_colors = [
          { color = "#FAB387"; index = 16; }
          { color = "#F5E0DC"; index = 17; }
        ];
      };
    };
  };
}
