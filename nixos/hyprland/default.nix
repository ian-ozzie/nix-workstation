{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../.
  ];

  environment.systemPackages = with pkgs; [
    appimage-run
    firefox
    kitty
    webkitgtk_6_0
  ];

  ozzie.workstation = {
    greetd = {
      enable = lib.mkDefault true;
      command = lib.mkDefault "Hyprland";
    };
  };

  programs.hyprland = {
    enable = true;
    package = with pkgs; hyprland;
    portalPackage = with pkgs; xdg-desktop-portal-hyprland;
  };
}
