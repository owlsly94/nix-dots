{
  description = "Web development environment (Node.js + npm/pnpm)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Node.js and package managers
          nodejs_22
          nodePackages.npm
          nodePackages.pnpm
          nodePackages.yarn
          
          # Development tools
          nodePackages.typescript
          nodePackages.typescript-language-server
          nodePackages.eslint
          nodePackages.prettier
          
          # Build tools
          nodePackages.vite
          
          # Useful utilities
          jq  # JSON processor
        ];

        shellHook = ''
          echo "🌐 Node.js ${pkgs.nodejs_22.version} development environment"
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          echo "Available commands:"
          echo "  node --version"
          echo "  npm --version"
          echo "  pnpm --version"
          echo "  yarn --version"
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          echo "💡 Tip: Use 'pnpm' for faster installs!"
          
          # Set npm to use local node_modules
          export NPM_CONFIG_PREFIX=$PWD/.npm-global
          export PATH=$PWD/.npm-global/bin:$PATH
        '';
      };
    };
}
