{
  description = "Ozzie's NixOS workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = _: {
    nixosModules = {
      gnome = import ./nixos/gnome;
    };
  };
}
