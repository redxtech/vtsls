{
  description = "LSP wrapper for typescript extension of vscode";

  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pnpm2nix.url = "github:nzbr/pnpm2nix-nzbr";
  };

  nixConfig = {
    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem = { config, self', inputs', pkgs, system, lib, ... }: {
        # define the packages provided by this flake
        packages = {
          # use pnpm2nix to package this project
          vtsls = inputs'.pnpm2nix.packages.mkPnpmPackage {
            pname = "vtsls";
            version = "v0.2.3";
            src = ./.;
            installInPlace = true;
          };

          # alias the package to default as well
          default = self'.packages.vtsls;
        };

        # define the default dev environment
        devenv.shells.default = {
          name = "vtsls";

          languages.javascript = {
            enable = true;

            pnpm = {
              enable = true;
              install.enable = true;
            };
          };

          packages = [ config.packages.default ];

          scripts.build.exec = "pnpm build";
          scripts.run.exec = "pnpm run";
        };
      };
    };
}
