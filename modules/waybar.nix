{ config, pkgs, ... }:

let
  # Simply change this variable to "catppuccin", "nord", "gruvbox", "rose-pine", or "tokyonight"
  selectedTheme = "tokyonight";

  # Define all theme colors in a Nix attribute set
  themes = {
    tokyonight = ''
      @define-color bg rgba(26, 27, 38, 0.9);
      @define-color bg_alt rgba(36, 40, 59, 1.0);
      @define-color fg #c0caf5;
      @define-color cyan #7dcfff;
      @define-color blue #7aa2f7;
      @define-color magenta #bb9af7;
      @define-color pink #ff007c;
      @define-color green #9ece6a;
      @define-color yellow #e0af68;
      @define-color red #f7768e;
      @define-color comment #565f89;
    '';
    catppuccin = ''
      @define-color bg rgba(30, 30, 46, 0.9);
      @define-color bg_alt rgba(17, 17, 27, 1.0);
      @define-color fg #cdd6f4;
      @define-color cyan #89dceb;
      @define-color blue #89b4fa;
      @define-color magenta #cba6f7;
      @define-color pink #f5c2e7;
      @define-color green #a6e3a1;
      @define-color yellow #f9e2af;
      @define-color red #f38ba8;
      @define-color comment #7f849c;
    '';
    nord = ''
      @define-color bg rgba(46, 52, 64, 0.9);
      @define-color bg_alt rgba(59, 66, 82, 1.0);
      @define-color fg #eceff4;
      @define-color cyan #88c0d0;
      @define-color blue #81a1c1;
      @define-color magenta #b48ead;
      @define-color pink #b48ead;
      @define-color green #a3be8c;
      @define-color yellow #ebcb8b;
      @define-color red #bf616a;
      @define-color comment #4c566a;
    '';
    gruvbox = ''
      @define-color bg rgba(40, 40, 40, 0.9);
      @define-color bg_alt rgba(50, 48, 47, 1.0);
      @define-color fg #ebdbb2;
      @define-color cyan #8ec07c;
      @define-color blue #458588;
      @define-color magenta #b16286;
      @define-color pink #d3869b;
      @define-color green #b8bb26;
      @define-color yellow #fabd2f;
      @define-color red #fb4934;
      @define-color comment #928374;
    '';
    rose-pine = ''
      @define-color bg rgba(25, 23, 36, 0.9);
      @define-color bg_alt rgba(31, 29, 46, 1.0);
      @define-color fg #e0def4;
      @define-color cyan #9ccfd8;
      @define-color blue #31748f;
      @define-color magenta #c4a7e7;
      @define-color pink #ebbcba;
      @define-color green #908caa;
      @define-color yellow #f6c177;
      @define-color red #eb6f92;
      @define-color comment #6e6a86;
    '';
  };
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "cpu"
          "temperature"
          "memory"
          "pulseaudio"
          "clock"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = " ";
            "5" = "󰿎 ";
            "6" = " ";
            "7" = " ";
            "8" = " ";
            "9" = "󰍇 ";
            "10" = " ";
          };
          sort-by-number = true;
        };

        "hyprland/window" = {
          format = "{title}";
          separate-outputs = true;
        };

        "cpu" = {
          format = "  {usage}%";
          on-click = "kitty -e btop";
        };

        "temperature" = {
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" ];
        };

        "memory" = {
          format = "  {used} GB";
          on-click = "kitty -e htop";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = " ";
          format-icons = {
            default = [ " " " " " " ];
          };
          on-click = "pavucontrol";
        };

        "clock" = {
          format = "󰃰  {:%H:%M %a %e.%b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "tray" = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };

   style = ''
      @import "colors.css";

      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 14.7px;
          min-height: 0;
      }

      window#waybar {
          background-color: @bg;
          color: @fg;
          border-bottom: 2px solid rgba(187, 154, 247, 0.2);
      }

      #workspaces, #taskbar, #window, #cpu, #memory, #temperature, #pulseaudio, #clock, #tray {
          margin: 4px 3px;
          padding: 2px 12px;
          border-radius: 12px;
          background-color: @bg_alt;
      }

      #workspaces button {
          padding: 0 8px;
          color: @comment;
          background: transparent;
          border-radius: 8px;
          transition: all 0.3s ease;
      }

      #workspaces button:hover { color: @cyan; }
      #workspaces button.active { color: @magenta; }
      #workspaces button.urgent { color: @red; background: rgba(247, 118, 142, 0.2); }

      #cpu { color: @magenta; }
      #temperature { color: @cyan; }
      #memory { color: @green; }
      #pulseaudio { color: @yellow; }
      #clock { color: @pink; }
      #pulseaudio.muted { color: @comment; }
      #temperature.critical { color: @bg; background-color: @red; }

      tooltip {
          background: @bg;
          border: 1px solid @magenta;
          border-radius: 8px;
      }
      tooltip label { color: @fg; }
    '';
  }; 
  home.file.".config/waybar/colors.css".text = themes."${selectedTheme}";
}
