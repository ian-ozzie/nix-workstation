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
    ./hyprpicker.nix
    ./hyprshot.nix
    ./hyprsunset.nix
    ./swaync.nix
    ./tofi.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    hyprcursor
    hyprpolkitagent
    pcmanfm
    playerctl
  ];

  ozzie.workstation = {
    tofi.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
  };
}
