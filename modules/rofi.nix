{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors;
in
{
  # Disable Stylix target for Rofi so custom rasi config works perfectly
  stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "configuration" = {
        modi = "drun";
        show-icons = true;
        display-drun = "Launch:";
        drun-display-format = "{name}";
        font = "JetBrainsMono Nerd Font 12";
      };

      "*" = {
        bg = mkLiteral "#${c.base00}";
        bg-alt = mkLiteral "#${c.base01}";
        fg = mkLiteral "#${c.base05}";
        cyan = mkLiteral "#${c.base0C}";
        blue = mkLiteral "#${c.base0D}";
        magenta = mkLiteral "#${c.base0E}";
        gray = mkLiteral "#${c.base03}";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };

      "window" = {
        width = mkLiteral "500px";
        height = mkLiteral "400px";
        background-color = mkLiteral "@bg";
        border = mkLiteral "2px";
        border-color = mkLiteral "@magenta";
        border-radius = mkLiteral "12px";
      };

      "mainbox" = {
        padding = mkLiteral "15px";
        children = map mkLiteral [ "inputbar" "listview" ];
      };

      "inputbar" = {
        margin = mkLiteral "0px 0px 10px 0px";
        padding = mkLiteral "10px";
        background-color = mkLiteral "@bg-alt";
        border = mkLiteral "1px";
        border-color = mkLiteral "@blue";
        border-radius = mkLiteral "8px";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      "prompt" = {
        text-color = mkLiteral "@blue";
        margin = mkLiteral "0px 5px 0px 0px";
      };

      "entry" = {
        text-color = mkLiteral "@fg";
        placeholder = "Search...";
        placeholder-color = mkLiteral "@gray";
        horizontal-align = mkLiteral "0";
      };

      "listview" = {
        margin = mkLiteral "5px 0px 0px 0px";
        columns = 1;
        lines = 8;
        fixed-height = true;
        scrollbar = false;
        spacing = mkLiteral "5px";
      };

      "element" = {
        padding = mkLiteral "8px";
        border-radius = mkLiteral "8px";
        spacing = mkLiteral "12px";
      };

      "element normal.normal, element alternate.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@bg-alt";
        text-color = mkLiteral "@cyan";
      };

      "element-icon" = {
        size = mkLiteral "36px";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
