{
  description = "A Flake for a Prisma development environment";

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
              openssl
              prisma-engines
            ];

            packages = with pkgs; [
              ## Typescript
              nodePackages.nodejs
              nodePackages.pnpm
              nodePackages.typescript
              nodePackages.typescript-language-server
            ];

            env = {
              LD_LIBRARY_PATH = "${pkgs.openssl}/lib";

              PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
              PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
              PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
            };
          };
      });
    };
}
