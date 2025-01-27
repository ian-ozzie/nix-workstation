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
    ./tofi.nix
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
    tofi.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
  };
}
