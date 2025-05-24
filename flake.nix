{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.05";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";

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
