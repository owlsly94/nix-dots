{ config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
      cpu = {
        governor = "performance";
        park_cores = false;
        pin_cores = false;
      };
      custom = {
        start = "${pkgs.dunst}/bin/dunstify -a 'Gamemode' 'Optimizations activated' -u low";
        end = "${pkgs.dunst}/bin/dunstify -a 'Gamemode' 'Optimizations deactivated' -u low";
      };
    };
  };
}
