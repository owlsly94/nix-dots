{ pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Init lua configuration
    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.loader.enable()
      require("owlsly")
    '';

    # External tools and dependencies
    extraPackages = with pkgs; [
      git
      ripgrep
      fd
      curl
    ];
  };

  # Copy nvim config files instead of symlinking them
  # This allows lazy-lock.json to be writable
  home.activation.setupNeovimConfig = lib.hm.dag.entryAfter ["linkGeneration"] ''
    mkdir -p $HOME/.config/nvim/{lua/owlsly,after/plugin}
    
    # Remove any symlinks that might have been created
    rm -f $HOME/.config/nvim/init.lua
    
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/init.lua} $HOME/.config/nvim/init.lua
    ${pkgs.coreutils}/bin/chmod 644 $HOME/.config/nvim/init.lua
    
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/lua/owlsly/init.lua} $HOME/.config/nvim/lua/owlsly/init.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/lua/owlsly/lazy.lua} $HOME/.config/nvim/lua/owlsly/lazy.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/lua/owlsly/options.lua} $HOME/.config/nvim/lua/owlsly/options.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/lua/owlsly/remaps.lua} $HOME/.config/nvim/lua/owlsly/remaps.lua
    
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/autocomplete.lua} $HOME/.config/nvim/after/plugin/autocomplete.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/autopairs.lua} $HOME/.config/nvim/after/plugin/autopairs.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/colorizer.lua} $HOME/.config/nvim/after/plugin/colorizer.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/colorscheme.lua} $HOME/.config/nvim/after/plugin/colorscheme.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/comment.lua} $HOME/.config/nvim/after/plugin/comment.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/db-owlsly.lua} $HOME/.config/nvim/after/plugin/db-owlsly.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/gitsigns.lua} $HOME/.config/nvim/after/plugin/gitsigns.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/lsp-config.lua} $HOME/.config/nvim/after/plugin/lsp-config.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/lualine.lua} $HOME/.config/nvim/after/plugin/lualine.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/nvim-treesitter.lua} $HOME/.config/nvim/after/plugin/nvim-treesitter.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/nvimtree.lua} $HOME/.config/nvim/after/plugin/nvimtree.lua
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/after/plugin/trouble.lua} $HOME/.config/nvim/after/plugin/trouble.lua
    
    ${pkgs.coreutils}/bin/cp -f ${../config/nvim/lazy-lock.json} $HOME/.config/nvim/lazy-lock.json
    ${pkgs.coreutils}/bin/chmod 644 $HOME/.config/nvim/lazy-lock.json
  '';
}
