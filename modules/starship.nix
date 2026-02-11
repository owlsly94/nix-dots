{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors;
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      command_timeout = 5000;

      format = "[](#${c.base01})$python$username[](bg:#${c.base02} fg:#${c.base01})$directory[](fg:#${c.base02} bg:#${c.base03})$git_branch$git_status[](fg:#${c.base03} bg:#${c.base0D})$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust[](fg:#${c.base0D} bg:#${c.base0C})$docker_context[](fg:#${c.base0C} bg:#${c.base0E})$time[ ](fg:#${c.base0E})";

      character = {
        success_symbol = "[➜](bold #${c.base0B})"; # Green
        error_symbol = "[➜](bold #${c.base08})";   # Red
      };

      username = {
        show_always = true;
        style_user = "bg:#${c.base01} fg:#${c.base05}";
        style_root = "bg:#${c.base01} fg:#${c.base08}";
        format = "[󰏒  $user ]($style)";
      };

      directory = {
        style = "bg:#${c.base02} fg:#${c.base0C}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "~" = " ";
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Videos" = "󰕧 ";
          ".config" = " ";
        };
      };

      git_branch = {
        symbol = "󰘬";
        style = "bg:#${c.base03} fg:#${c.base05}";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:#${c.base03} fg:#${c.base08}";
        format = "[$all_status$ahead_behind ]($style)";
      };

      python = {
        symbol = "󱔎 ";
        style = "bg:#${c.base01} fg:#${c.base09}"; # base09 is typically Orange
        format = "[ \${symbol}(\$virtualenv )]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#${c.base0E} fg:#${c.base00}";
        format = "[ $time ]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:#${c.base0D} fg:#${c.base00}";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = " ";
        style = "bg:#${c.base0D} fg:#${c.base00}";
        format = "[ $symbol ($version) ]($style)";
      };

      nodejs = {
        symbol = "󰎙 ";
        style = "bg:#${c.base0D} fg:#${c.base00}";
        format = "[ $symbol ($version) ]($style)";
      };

      golang = {
        symbol = " ";
        style = "bg:#${c.base0D} fg:#${c.base00}";
        format = "[ $symbol ($version) ]($style)";
      };

      docker_context = {
        symbol = "󰡨 ";
        style = "bg:#${c.base0C} fg:#${c.base00}";
        format = "[ $symbol $context ]($style)";
      };
    };
  };
}
