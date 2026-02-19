{
  description = "Python development environment";

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
          # Python interpreter
          python312
          
          # Python tools
          python312Packages.pip
          python312Packages.virtualenv
          python312Packages.setuptools
          
          # Common libraries (add/remove as needed)
          python312Packages.requests
          python312Packages.flask
          python312Packages.fastapi
          python312Packages.uvicorn
          python312Packages.numpy
          python312Packages.pandas
          python312Packages.matplotlib
          python312Packages.pytest
          python312Packages.black
          python312Packages.pylint
          
          # Development tools
          ruff  # Fast Python linter
        ];

        shellHook = ''
          echo "🐍 Python ${pkgs.python312.version} development environment"
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          echo "Available commands:"
          echo "  python --version"
          echo "  pip install <package>"
          echo "  pytest"
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          
          # Create virtual environment if it doesn't exist
          if [ ! -d .venv ]; then
            echo "Creating virtual environment..."
            python -m venv .venv
          fi
          
          # Activate virtual environment
          source .venv/bin/activate
        '';
      };
    };
}
