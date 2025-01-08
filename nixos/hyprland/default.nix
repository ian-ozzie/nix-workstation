{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation) theme;
in
{
  imports = [
    ./stylix.nix
  ];

  ozzie.workstation = {
    hyprland.enable = true;

    greetd = {
      enable = lib.mkDefault true;
      command = lib.mkDefault "Hyprland";
    };
  };
}
