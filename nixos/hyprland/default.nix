{
  lib,
  ...
}:
{
  imports = [
    ./stylix.nix
    ./xdg.nix
  ];

  ozzie.workstation = {
    hyprland.enable = true;
    theme.wallpaper.svg = lib.mkDefault ./square.svg;

    ly = {
      enable = lib.mkDefault true;
    };

    plymouth = {
      enable = lib.mkDefault true;
    };
  };
}
