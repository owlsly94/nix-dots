{ pkgs, ... }:
let
  rofiAskpass = pkgs.writeShellScriptBin "rofi-askpass" ''
    ${pkgs.rofi}/bin/rofi -dmenu -password -p "$1" -theme-str 'window {width: 400px;}'
  '';
  themeSwitcher = pkgs.writeShellScriptBin "stylix-theme-picker" ''
    THEMES_DIR="${pkgs.base16-schemes}/share/themes"
    CONFIG_DIR="/home/owlsly/nix-dots"
    THEME_FILE="/home/owlsly/nix-dots/modules/home/current-theme.nix"
    
    # Get list of available themes and show in rofi
    SELECTED=$(ls "$THEMES_DIR" | sed 's/\.yaml$//' | ${pkgs.rofi}/bin/rofi -dmenu -p "Select Stylix Theme" -i)
    
    if [ -n "$SELECTED" ]; then
      # Update the current-theme.nix file
      echo "\"$SELECTED\"" > "$THEME_FILE"
      
      # Show persistent notification and capture its ID
      NOTIF_ID=$(${pkgs.dunst}/bin/dunstify -p "Stylix" "Changing theme to: $SELECTED - Please wait..." -t 0)
      
      # Use rofi for password
      SUDO_ASKPASS=${rofiAskpass}/bin/rofi-askpass sudo -A nixos-rebuild switch --flake "$CONFIG_DIR"#OwlslyBox
      
      # Close the persistent notification
      ${pkgs.dunst}/bin/dunstify -C "$NOTIF_ID"
      
      if [ $? -eq 0 ]; then
        ${pkgs.dunst}/bin/dunstify "Stylix" "Theme applied: $SELECTED" -t 3000
      else
        ${pkgs.dunst}/bin/dunstify "Stylix" "Theme switch failed!" -u critical -t 5000
      fi
    fi
  '';
in
{
  home.packages = [ themeSwitcher rofiAskpass pkgs.dunst ];
}
