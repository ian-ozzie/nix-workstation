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
    catppuccin-cursors.mochaMauve
    hyprcursor
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprshot
    hyprsunset
    tofi
  ];

  ozzie.workstation = {
    waybar.enable = lib.mkDefault true;
  };
}
