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
    }@inputs:
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

      packages = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          presets = import ./options/presets.nix { inherit pkgs; };

          mkNvf =
            {
              preset ? null,
              withOptions ? true,
            }:
            (nixpkgs.lib.nixosSystem {
              inherit system;

              specialArgs = { inherit inputs; };

              modules = [
                (import ./modules).nvf
              ]
              ++ lib.optionals withOptions [
                ./options

                { ozzie.appearance.preset = preset; }
              ];
            }).config.programs.nvf.finalPackage;
        in
        {
          nvf = mkNvf { };
          nvf-bare = mkNvf { withOptions = false; };
        }
        // lib.mapAttrs' (
          name: _:
          lib.nameValuePair "nvf-${name}" (mkNvf {
            preset = name;
          })
        ) presets
      );

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
