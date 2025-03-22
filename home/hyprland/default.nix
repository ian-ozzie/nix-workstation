{
  lib,
  pkgs,
  ...
}:
{
  gtk.enable = true;
  qt.enable = true;
  xdg.enable = true;

  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./swaync.nix
    ./tofi.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    hyprcursor
    hyprpicker
    hyprpolkitagent
    hyprshot
    hyprsunset
    playerctl
    swappy
  ];

  ozzie.workstation = {
    tofi.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
  };
}
