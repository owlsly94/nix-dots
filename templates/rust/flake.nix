{
  description = "Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      system = "x86_64-linux";
      overlays = [ (import rust-overlay) ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Rust toolchain (stable)
          rust-bin.stable.latest.default
          
          # Additional Rust tools
          rust-analyzer  # LSP for IDE support
          cargo-watch    # Auto-rebuild on file changes
          cargo-edit     # cargo add, cargo rm commands
          cargo-expand   # Show macro expansions
          clippy         # Linter
          rustfmt        # Formatter
          
          # Build dependencies
          pkg-config
          openssl
          
          # Useful tools
          bacon  # Background rust code checker
        ];

        shellHook = ''
          echo "🦀 Rust development environment loaded"
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          rustc --version
          cargo --version
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
          echo "Available commands:"
          echo "  cargo new <name>      - Create new project"
          echo "  cargo build          - Build project"
          echo "  cargo run            - Run project"
          echo "  cargo test           - Run tests"
          echo "  cargo watch -x run   - Auto-run on changes"
          echo "  bacon                - Background checker"
          echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        '';

        # Set Rust backtrace for better error messages
        RUST_BACKTRACE = "1";
      };
    };
}
