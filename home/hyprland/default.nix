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
    ./hyprlauncher.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpicker.nix
    ./hyprpolkitagent.nix
    ./hyprsunset.nix
    ./kitty.nix
    ./pcmanfm.nix
    ./satty.nix
    ./swappy.nix
    ./swaync.nix
    ./tofi.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    hyprcursor
    playerctl
  ];

  ozzie.workstation = {
    hypridle.enable = lib.mkDefault true;
    hyprland.binds = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    hyprlauncher.enable = lib.mkDefault true;
    hyprlock.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    hyprpicker.enable = lib.mkDefault true;
    hyprpolkitagent.enable = lib.mkDefault true;
    hyprsunset.enable = lib.mkDefault true;
    kitty.binds = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    pcmanfm.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    satty.enable = lib.mkDefault true;
    swappy.enable = lib.mkDefault false;
    swaync.enable = lib.mkDefault true;
    tofi.enable = lib.mkDefault false;
    waybar.enable = lib.mkDefault true;
    wlogout.enable = lib.mkDefault false;
  };
}
