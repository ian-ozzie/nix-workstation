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
    ./hyprpolkitagent.nix
    ./hyprshot.nix
    ./hyprsunset.nix
    ./swaync.nix
    ./tofi.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    hyprcursor
    pcmanfm
    playerctl
  ];

  ozzie.workstation = {
    hypridle.enable = lib.mkDefault true;
    hyprlock.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    hyprpicker.enable = lib.mkDefault true;
    hyprpolkitagent.enable = lib.mkDefault true;
    tofi.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
  };
}
