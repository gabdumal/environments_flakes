{
  description = "A Flake for a Typescript development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell.override
          { }
          {
            packages = with pkgs; [
              ## Development
              nodePackages.nodejs
              nodePackages.pnpm
              nodePackages.typescript
              nodePackages.typescript-language-server
            ];
          };
      });
    };
}
