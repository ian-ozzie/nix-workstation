{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    hyprpaper
  ];

  ozzie.workstation = {
    waybar.enable = lib.mkDefault true;
  };
}
