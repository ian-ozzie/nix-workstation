{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
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

      nvf = import ./nixos/nvf.nix;
    };

    homeModules = {
      default = import ./home;

      hyprland = import ./home/hyprland;

      nvf = import ./home/nvf.nix;
    };
  };
}
