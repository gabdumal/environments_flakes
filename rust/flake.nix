{
  description = "A Flake for a Rust development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };
      toolchain = pkgs.rust-bin.fromRustupToolchainFile ./toolchain.toml;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          toolchain
          pkgs.rust-analyzer-unwrapped
        ];

        RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";
      };
    };
}
