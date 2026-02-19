{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
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
          hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" ];
        };

        "memory" = {
          format = "  {used} GB";
          on-click = "kitty -e htop";
          tooltip = true;
          tooltip-format = "RAM: {used:0.1f}GB / {total:0.1f}GB ({percentage}%)\nSwap: {swapUsed:0.1f}GB / {swapTotal:0.1f}GB";
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
          rotate = 0;
          format-alt = "{  %d·%m·%y}";
          tooltip-format = "<span>{calendar}</span>";
          calendar = {
            mode = "month";
            format = {
              months = "<span color='#${c.base0E}'><b>{}</b></span>";
              days = "<span color='#${c.base05}'><b>{}</b></span>";
              weekdays = "<span color='#${c.base0C}'><b>{}</b></span>";
              today = "<span color='#${c.base0A}'><b>{}</b></span>";
            };
          };
        };
        
        "tray" = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };

    style = ''
      /* Using Stylix hex colors - c.baseXX returns hex without # */
      
      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 15px;
          min-height: 0;
      }

      window#waybar {
          background: linear-gradient(to bottom, #${c.base00}, rgba(0, 0, 0, 1));
          color: #${c.base05};
          /*border-bottom: 2px solid #${c.base0A};*/
	        /*border-top: 2px solid #${c.base0A};*/
      }

      #waybar.empty .modules-center{
        opacity:0;
      }

      #taskbar, #window, #cpu, #memory, #temperature, #pulseaudio, #clock, #tray {
          margin: 6px 3px;
          padding: 2px 12px;
          border-radius: 12px;
          background-color: #${c.base01};
      }

      #workspaces {
        margin: 6px 3px;
        padding: 6px;
        border-radius: 12px;
        background-color: #${c.base01};
      }

      #workspaces button {
          padding: 0 0 0 2px;
          margin: 0 3px;
          color: #${c.base01};
          background: #${c.base0E};
          border-radius: 50%;
          transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
          min-width: 24px;
          min-height: 24px;
      }
      
      #workspaces button:hover { 
          background-color: #${c.base0B}; 
          color: #${c.base01};
      }

      #workspaces button.active { 
          color: #${c.base00}; 
          background-color: #${c.base0D};
          font-weight: bold;
          border-radius: 16px;
          border: none;
          padding: 0 12px;
      }

      #workspaces button.urgent { 
        color: #${c.base00};
        background-color: #${c.base08};
        animation: urgent-blink 1s ease infinite;
      }

      @keyframes blink {
        to {
          opacity: 0.7;
        }
      }
      
      #pulseaudio {
        transition: all 0.2s ease;
      }

      #pulseaudio.muted {
        color: #${c.base03};
        opacity: 0.5;
      }

      #cpu { color: #${c.base0E}; }
      #temperature { color: #${c.base0C}; }
      #memory { color: #${c.base0B}; }
      #pulseaudio { color: #${c.base0A}; }
      #clock { color: #${c.base0F}; }
      #pulseaudio.muted { color: #${c.base03}; }
      
      #temperature.critical { 
          color: #${c.base00}; 
          background-color: #${c.base08}; 
      }

      tooltip {
          background: #${c.base00};
          border: 1px solid #${c.base0D};
          border-radius: 8px;
      }
      
      tooltip label { 
          color: #${c.base05}; 
      }
    '';
  }; 
}
