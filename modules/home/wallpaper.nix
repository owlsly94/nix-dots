{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors;
  wall-rasi = pkgs.writeText "wall-style.rasi" ''
    configuration {
        show-icons: true;
        icon-theme: "Papirus";
        font: "JetBrainsMono Nerd Font 14";
    }

    * {
        bg: #${c.base00};
        bg-alt: #${c.base01};
        bg-selected: #${c.base03};
        fg: #${c.base05};
        fg-alt: #${c.base05};
        accent: #${c.base0A};
        transparent: rgba(0,0,0,0);
    }

    window {
        width: 1100px; 
        height: 485px;  
        background-color: @bg;
        border: 2px;
        border-color: #1a1e24;
        border-radius: 12px;
    }

    mainbox {
        background-color: @transparent;
        children: [ "inputbar", "listview", "message" ];
    }

    inputbar {
        padding: 20px;
        background-color: @transparent;
        children: [ "prompt", "entry" ];
    }

    prompt {
        background-color: @transparent;
        text-color: @accent;
        margin: 0px 10px 0px 0px;
    }

    entry {
        background-color: @transparent;
        text-color: @fg;
        placeholder: "Search wallpapers...";
        placeholder-color: #444444;
    }

    listview {
        background-color: @transparent;
        layout: horizontal;
        spacing: 25px;
        padding: 10px 25px;
        fixed-columns: true;
        expand: false;
        horizontal-align: 0.5;
    }

    message {
        background-color: @transparent;
        border: 1px 0px 0px 0px;
        border-color: #1a1e24;
        padding: 2px 0px;
        margin: 0px 20px;
    }

    textbox {
        text-color: @fg-alt;
        background-color: @transparent;
        horizontal-align: 0.5;
        vertical-align: 0.5;
        font: "JetBrainsMono Nerd Font 12";
    }

    element {
        background-color: @bg-alt;
        orientation: vertical;
        padding: 15px;
        border-radius: 10px;
        spacing: 10px;
        border: 2px;
        border-color: @transparent;
        width: 320px; 
    }

    element selected {
        background-color: @bg-selected;
        border-color: @accent;
    }

    element-icon {
        size: 260px; 
        horizontal-align: 0.5;
        background-color: @transparent;
    }

    element-text {
        background-color: @transparent;
        text-color: @fg-alt;
        horizontal-align: 0.5;
        vertical-align: 0.5;
    }

    element-text selected {
        text-color: @accent;
    }
  '';

  wall-selector = pkgs.writeShellScriptBin "wall-selector" ''
    WALL_DIR="$HOME/.config/wallpapers"

    if [ ! -d "$WALL_DIR" ]; then
        ${pkgs.dunst}/bin/dunstify -a "Error" "Wallpaper directory not found: $WALL_DIR" -u low
        exit 1
    fi

    list_wallpapers() {
        for file in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
            [ -e "$file" ] || continue
            echo -en "$(basename "$file")\0icon\x1f$file\n"
        done
    }

    choice=$(list_wallpapers | ${pkgs.rofi}/bin/rofi -dmenu \
      -theme ${wall-rasi} \
      -p "Select Wallpaper" \
      -mesg "Use arrow keys (← →) to navigate; Enter to apply")

    if [ -n "$choice" ]; then
        ${pkgs.swww}/bin/swww img "$WALL_DIR/$choice" --transition-type center --transition-fps 60
        ${pkgs.dunst}/bin/dunstify -a "Wallpaper" "Changed to $choice" -u low
    fi
  '';

in
{
  home.packages = [ 
    wall-selector 
    pkgs.swww 
  ];

  # Manage swww-daemon as a proper systemd service
  systemd.user.services.swww = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
