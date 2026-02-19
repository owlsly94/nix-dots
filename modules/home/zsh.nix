{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 2000;
      save = 2000;
      path = "${config.home.homeDirectory}/.histfile";
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    defaultKeymap = "viins";

    envExtra = ''
      export PATH=$PATH:/var/lib/flatpak/exports/bin:~/.local/share/flatpak/exports/bin
      export PATH="$HOME/.emacs.d/bin:$PATH"
    '';

    initContent = lib.mkBefore ''
      # Completion i zstyle
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)

      lazyg() {
        git add .
        git commit -m "$1"
        git push
      }

      myip() { ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1; }
      pubip() { curl -s ifconfig.me; }
      mem() { free -h; }
      dus() { du -sh * | sort -hr; }
      reload() { source ~/.zshrc && echo "✅ Reloaded .zshrc"; }
      serve() { python3 -m http.server "''${1:-8000}"; }
      
      weather() { curl wttr.in/"''${1:-Belgrade}"; }
      myhost() {
        echo "IP: $(curl -s ifconfig.me)"
        echo "Host: $(hostnamectl)"
        echo "Uptime: $(uptime -p)"
      }

      extract() {
        if [ -f "$1" ]; then
          case "$1" in
            *.tar.bz2|*.tbz2) tar xjf "$1" ;;
            *.tar.gz|*.tgz)   tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }

      if command -v zoxide &> /dev/null; then
        eval "$(zoxide init zsh)"
      fi
    '';

    autocd = true;
    completionInit = "autoload -Uz compinit && compinit";
    
    shellAliases = {
      ll = "eza --icons -a --group-directories-first -1 --no-user --long";
      l = "eza --icons --all";
      lss = "eza --icons -a --group-directories-first -1";
      v = "nvim";
      sv = "sudo nvim";
      how = "tldr";
      emacs = "emacsclient -c -a 'emacs'";
      cp = "cp -i";
      mv = "mv -i";
      server = "ssh stefan@192.168.1.21";
      movie = "mpv --profile=movies";
      yt = "mpv --profile=youtube";
      conf = "nvim $HOME/nix-dots";
      cd = "z";
      update = "cd $HOME/nix-dots && sudo nixos-rebuild switch --flake .#OwlslyBox";
      upgrade = "cd $HOME/nix-dots && nix flake update && sudo nixos-rebuild switch --flake .#OwlslyBox";
      devpy = "nix flake init -t ~/nix-dots#python && echo 'use flake' > .envrc && direnv allow";
      devweb = "nix flake init -t ~/nix-dots#web && echo 'use flake' > .envrc && direnv allow";
    };
  };

  home.packages = with pkgs; [
    eza
    tldr
    zoxide
    unrar
    p7zip
  ];
}
