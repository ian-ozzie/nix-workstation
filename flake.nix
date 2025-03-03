{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.11";
    };

    stylix = {
      url = "github:nix-community/stylix/release-24.11";

      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = _: {
    lib = import ./lib;

    nixosModules = {
      default = import ./nixos;

      gnome = import ./nixos/gnome;
      hyprland = import ./nixos/hyprland;
    };

    homeModules = {
      default = import ./home;

      hyprland = import ./home/hyprland;
    };
  };
}
