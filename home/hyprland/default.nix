{
  lib,
  ...
}:
{
  imports = [
    ../.

    ./hyprland.nix
    ./waybar.nix
  ];

  ozzie.workstation = {
    waybar.enable = lib.mkDefault true;
  };
}
