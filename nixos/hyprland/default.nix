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
    hyprland.enable = true;

    greetd = {
      enable = lib.mkDefault true;
      command = lib.mkDefault "Hyprland";
    };
  };
}
