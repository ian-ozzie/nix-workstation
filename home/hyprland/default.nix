{
  lib,
  ...
}:
{
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./waybar.nix
  ];

  ozzie.workstation = {
    waybar.enable = lib.mkDefault true;
  };
}
