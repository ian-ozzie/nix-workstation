{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    dev-tools.url = "git+ssh://git/ozzie/nix-dev-tools.git";
    nixpkgs.follows = "dev-tools/nixpkgs";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-26.05";
    };

    nvf = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:notashelf/nvf";
    };
  };

  outputs =
    {
      dev-tools,
      nixpkgs,
      ...
    }:
    let
      inherit (dev-tools.lib) forSystem hooks;
      inherit (nixpkgs) lib;

      forEachSystem = lib.genAttrs [
        "x86_64-linux"
      ];

      nixHooks = hooks.merge [
        hooks.presets.general
        hooks.presets.nix
      ];
    in
    {
      formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.nixfmt);
      homeModules = import ./home;
      lib = import ./lib;
      nixosModules = import ./modules;

      checks = forEachSystem (system: {
        lint = (forSystem system).gitHooks.run {
          hooks = hooks.without [ "nix-flake-check" ] nixHooks;
          src = ./.;
        };
      });

      devShells = forEachSystem (system: {
        default = (forSystem system).mkDevShell {
          src = ./.;

          bundles = [
            "common"
            "nix"
          ];

          hooks = nixHooks;
        };
      });
    };
}
