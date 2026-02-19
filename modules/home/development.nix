{ config, pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = [
    (pkgs.writeShellScriptBin "devpy" ''
      if [ -f flake.nix ]; then
        echo "❌ flake.nix already exists in this directory!"
        exit 1
      fi
      nix flake init -t ~/nix-dots#python
      echo "use flake" > .envrc
      direnv allow
      echo "✅ Python environment created! It will load automatically."
    '')
    
    (pkgs.writeShellScriptBin "devweb" ''
      if [ -f flake.nix ]; then
        echo "❌ flake.nix already exists in this directory!"
        exit 1
      fi
      nix flake init -t ~/nix-dots#web
      echo "use flake" > .envrc
      direnv allow
      echo "✅ Web environment created! It will load automatically."
    '')

    (pkgs.writeShellScriptBin "devrust" ''
      if [ -f flake.nix ]; then
        echo "❌ flake.nix already exists in this directory!"
        exit 1
      fi
      nix flake init -t ~/nix-dots#rust
      echo "use flake" > .envrc
      direnv allow
      echo "✅ Rust environment created! It will load automatically."
    '')
  ];
}
