{ pkgs, ... }:
let
  themeSwitcher = pkgs.writeShellScriptBin "stylix-theme-picker" ''
    THEMES_DIR="${pkgs.base16-schemes}/share/themes"
    CONFIG_DIR="/home/owlsly/nix-dots"
    THEME_FILE="/home/owlsly/nix-dots/modules/home/current-theme.nix"
    
    # Get list of available themes and show in rofi
    SELECTED=$(ls "$THEMES_DIR" | sed 's/\.yaml$//' | ${pkgs.rofi}/bin/rofi -dmenu -p "Select Stylix Theme" -i)
    
    if [ -n "$SELECTED" ]; then
      # Update the current-theme.nix file
      echo "\"$SELECTED\"" > "$THEME_FILE"
      
      ${pkgs.dunst}/bin/dunstify "Stylix" "Switching to: $SELECTED" -t 3000
      
      # Open terminal and run rebuild
      ${pkgs.kitty}/bin/kitty -e bash -c '
        echo "Rebuilding with theme: '"$SELECTED"'"
        echo "================================"
        echo ""
        
        # NixOS rebuild
        sudo nixos-rebuild switch --flake '"$CONFIG_DIR"'#OwlslyBox
        
        echo ""
        echo "Rebuild complete! Closing in 2 seconds..."
        sleep 2
      '
      
      ${pkgs.dunst}/bin/dunstify "Stylix" "Theme applied: $SELECTED" -t 3000
    fi
  '';
in
{
  home.packages = [ themeSwitcher pkgs.dunst ];
}
