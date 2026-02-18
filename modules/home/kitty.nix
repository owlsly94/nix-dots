{ pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      background_opacity = lib.mkForce "0.9";
      dynamic_background_opacity = true;
    };
  };
}
