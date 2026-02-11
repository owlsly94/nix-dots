{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################
      env = [
        "GDK_BACKEND,wayland,x11"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland,x11"
        "CLUTTER_BACKEND,wayland"
        "GDK_SCALE,1"
        "XCURSOR_SIZE,20"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "MOZ_ENABLE_WAYLAND,1"
        "CHROME_CONFIG_FLAGS,--password-store=gnome-libsecret"
        "BROWSER,google-chrome-stable"
      ];

      ###################
      ### MY PROGRAMS ###
      ###################
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";
      "$browser" = "firefox";
      "$browser_p" = "firefox -p";
      "$browser2" = "brave";
      "$myEditor" = "code";
      "$steam" = "~/.config/hypr/scripts/steam.sh";
      "$screenshot" = "grim -g \"$(slurp)\" ~/Pictures/screenshot_$(date '+%Y-%m-%d_%H-%M-%S').png";
      "$HBO" = "thorium-browser --app=\"https://play.hbomax.com/\" --window-size=1900,1100";

      #################
      ### AUTOSTART ###
      #################
      "exec-once" = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "gnome-keyring-daemon --start --components=secrets"
        "~/.config/hypr/scripts/xdg.sh"
        "dunst"
        "swww-daemon"
	"pypr"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "udiskie"
        "hyprctl setcursor Bibata-Modern-Ice 20"
        "gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'"
        "gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark'"
        "gsettings set org.gnome.desktop.interface icon-theme 'Tokyonight-Dark-Cyan'"
        "gsettings set org.gnome.desktop.interface color-scheme prefer-dark"
        "/usr/bin/pypr"
      ];

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################
      windowrulev2 = [
        # Workspace 2: Browsers
        "workspace 2, class:^(google-chrome)$"
        "workspace 2, class:^(firefox)$"
        "workspace 2, class:^(zen-alpha)$" # Adding Zen just in case

        # Workspace 3: Code
        "workspace 3, class:^(code-url-handler)$"
        "workspace 3, class:^(code)$"

        # Workspace 4: File Manager
        "workspace 4, class:^(thunar)$"

        # Workspace 6: Media/Streaming
        "workspace 6, class:^(com.obsproject.Studio)$"

        # Workspace 7: Gaming
        "workspace 7, class:^(steam)$"
        "workspace 7, class:^(org.prismlauncher.PrismLauncher)$"
        "workspace 7, class:^(lutris)$"

        # Workspace 8: Communication
        "workspace 8, class:^(discord)$"
        "workspace 8, class:^(vesktop)$" # Common discord alternative

        # General Fixes
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      #####################
      ### LOOK AND FEEL ###
      #####################
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        layout = "master";
        allow_tearing = false;
      };

      decoration = {
        rounding = 6;
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        dim_inactive = true;
        dim_strength = 0.1;

        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          new_optimizations = true;
          special = true;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      master = {
        orientation = "left";
        mfact = 0.5;
        new_on_top = true;
      };

      #############
      ### INPUT ###
      #############
      monitor = ",preferred,auto,auto";

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        numlock_by_default = true;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      ###################
      ### KEYBINDINGS ###
      ###################
      bind = [
        ## Window Management
        "ALT, RETURN, exec, $terminal"
        "ALT SHIFT, C, killactive"
        "ALT SHIFT, Q, exit"
        "ALT, F, togglefloating"

        ## Launcher & Menus
        "ALT, SPACE, exec, rofi -show drun"
        "SUPER, SPACE, exec, wlogout"

        ## Browsers & Productivity
        "SUPER, F, exec, firefox"
        "SUPER SHIFT, F, exec, $browser_p"
        "SUPER, Z, exec, zen-browser"
        "SUPER, B, exec, google-chrome-stable"
        "SUPER, C, exec, code"
        "SUPER, O, exec, obs"
        "ALT, D, exec, thunar"

        ## Media & Gaming
        "ALT, G, exec, $steam"
        "ALT, J, exec, jellyfin-desktop"
        "SUPER, P, exec, $screenshot"
        "SUPER, M, exec, prismlauncher"
        "SUPER, E, exec, rofimoji --selector rofi --action copy"

        ## System & Scripts
        "ALT, L, exec, hyprlock"
	"SUPER, W, exec, wall-selector"
        "ALT SHIFT, R, exec, pkill -SIGUSR2 waybar"

        ## Scratchpads (Pyprland)
        "SUPER, 1, exec, pypr toggle term"
        "ALT, S, togglespecialworkspace, magic"
        "ALT SHIFT, S, movetoworkspace, special:magic"

        ## Master Layout & Resize
        "SUPER, RIGHT, layoutmsg, cyclenext"
        "SUPER, LEFT, layoutmsg, cycleprev"
        "SUPER SHIFT, LEFT, layoutmsg, swapwithmaster"
        "ALT SHIFT, LEFT, resizeactive, -20 0"
        "ALT SHIFT, RIGHT, resizeactive, 20 0"

        ## Audio Controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        ## Focus Movement
        "ALT, left, movefocus, l"
        "ALT, right, movefocus, r"
        "ALT, up, movefocus, u"
        "ALT, down, movefocus, d"

        ## Workspace Navigation
        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"
        "ALT, 6, workspace, 6"
        "ALT, 7, workspace, 7"
        "ALT, 8, workspace, 8"
        "ALT, 9, workspace, 9"
        "ALT, 0, workspace, 10"

        ## Move to Workspace
        "ALT SHIFT, 1, movetoworkspace, 1"
        "ALT SHIFT, 2, movetoworkspace, 2"
        "ALT SHIFT, 3, movetoworkspace, 3"
        "ALT SHIFT, 4, movetoworkspace, 4"
        "ALT SHIFT, 5, movetoworkspace, 5"
        "ALT SHIFT, 6, movetoworkspace, 6"
        "ALT SHIFT, 7, movetoworkspace, 7"
        "ALT SHIFT, 8, movetoworkspace, 8"
        "ALT SHIFT, 9, movetoworkspace, 9"
        "ALT SHIFT, 0, movetoworkspace, 10"

        ## Mouse Bindings
        "ALT, mouse_down, workspace, e+1"
        "ALT, mouse_up, workspace, e-1"
      ];

      bindm = [
        "ALT, mouse:272, movewindow"
        "ALT, mouse:273, resizewindow"
      ];
    };
  };
}
