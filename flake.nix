{
  description = "Language server for typescript";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = {
          vtsls = pkgs.buildNpmPackage {
            pname = "vtsls";
            version = "0.0.1";
            src = ./packages/server;
            npmDepsHash = "sha256-mQubnXw+U07DvjE0R4DWqlady/FK9J0VExZtNgFkf2M=";
          };

          default = self'.packages.vtsls;
        };
      };
    };
}
