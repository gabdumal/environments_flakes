{
  description = "Development environment for C and C++";

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
            packages = with pkgs; [
              bashInteractive
              cmake
              doxygen
              llvmPackages_latest.clang-tools
              llvmPackages_latest.bintools
              llvmPackages_latest.clang
              llvmPackages_latest.libclc
              llvmPackages_latest.libcxx
              llvmPackages_latest.lldb
              llvmPackages_latest.lldbPlugins.llef
              llvmPackages.lldb-manpages
              llvmPackages_latest.llvm
              llvmPackages_latest.mlir
              llvmPackages_latest.openmp
              llvmPackages_latest.stdenv
              ninja
              python3
              vcpkg
              vcpkg-tool
            ];
          };
      });
    };
}
