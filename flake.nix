{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.11";
    };
  };

  outputs = _: {
    nixosModules = {
      gnome = import ./nixos/gnome;
      hyprland = import ./nixos/hyprland;
    };
  };
}
