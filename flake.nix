{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };

    nvf = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:notashelf/nvf";
    };

    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/stylix/release-25.11";
    };
  };

  outputs =
    {
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
        in
        {
          default = mkShell {
            packages = with pkgs; [
              nixd
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
