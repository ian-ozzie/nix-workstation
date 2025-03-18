{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    stylix = {
      url = "github:nix-community/stylix";

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
