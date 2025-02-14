{
  description = "Development environment for PNPM";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSupportedSystem = f: nixpkgs.lib.genAttrs
        supportedSystems
        (
          system: f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell
          {
            nativeBuildInputs = with pkgs; [
              bashInteractive
            ];

            buildInputs = with pkgs; [
              libuuid
              openssl
              python3
            ];

            packages = with pkgs; [
              nodePackages.nodejs
              nodePackages.pnpm
              nodePackages.typescript
              nodePackages.typescript-language-server
            ];

            env = {
              LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [ libuuid openssl ];
            };
          };
      });
    };
}
