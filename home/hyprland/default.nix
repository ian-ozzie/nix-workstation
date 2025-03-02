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
    hyprcursor
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprshot
    hyprsunset
  ];

  ozzie.workstation = {
    tofi.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
  };
}
