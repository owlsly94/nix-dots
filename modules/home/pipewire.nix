{ pkgs, ... }:

{
  xdg.configFile."pipewire/pipewire.conf.d/99-custom.conf" = {
    text = ''
      default.clock.allowed-rates = [ 44100 48000 96000 ]
      default.clock.min-quantum = 32
      default.clock.default-quantum = 256
    '';
  };

  xdg.configFile."wireplumber/wireplumber.conf.d/99-custom.conf" = {
    text = ''
      wireplumber.settings = {
        bluetooth.autoswitch-to-headphones = false
      }
    '';
  };

  home.packages = with pkgs; [
    pipewire
    wireplumber
    pavucontrol
  ];
}
