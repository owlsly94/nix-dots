{ pkgs, config, ... }:
let
  c = config.lib.stylix.colors;
in
{
  home.packages = [ pkgs.imv ];
  
  xdg.configFile."imv/config".text = ''
    [options]
    background = #${c.base00}
    fullscreen = false
    scaling = full
    upscaling = linear
    overlay = true
    overlay_font = Inter:12
    
    [binds]
    q = quit
    <Left> = prev
    <Right> = next
    j = next
    k = prev
    f = fullscreen
  '';
}
