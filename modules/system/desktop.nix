{ config, pkgs, ... }:
{
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true;
      user = "owlsly";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
