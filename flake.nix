{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    git-hooks = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cachix/git-hooks.nix";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-26.05";
    };

    nvf = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:notashelf/nvf";
    };

    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/stylix/release-26.05";
    };
  };

  outputs =
    {
      git-hooks,
      nixpkgs,
      ...
    }:
    let
      systems = [ "x86_64-linux" ];
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (
        system:
        let
          inherit (nixpkgs.legacyPackages.${system}) mkShell;

          pkgs = import nixpkgs {
            inherit system;
          };

          gitHooks = git-hooks.lib.${system}.run {
            src = ./.;

            hooks = {
              deadnix.enable = true;
              nixfmt.enable = true;

              check-flake = {
                enable = true;
                entry = "nix flake check";
                pass_filenames = false;
                types = [ "nix" ];
              };
            };
          };
        in
        {
          default = mkShell {
            inherit (gitHooks) shellHook;

            buildInputs = gitHooks.enabledPackages;

            packages = with pkgs; [
              nixd
              xc
            ];
          };
        }
      );

      lib = import ./lib;

      nixosModules = {
        default = import ./nixos;

        gnome = import ./nixos/gnome;
        hyprland = import ./nixos/hyprland;

        nvf = import ./nixos/nvf.nix;
      };

      homeModules = {
        default = import ./home;

        hyprland = import ./home/hyprland;

        nvf = import ./home/nvf.nix;
      };
    };
}
