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

    greetd = {
      enable = lib.mkDefault true;
      command = lib.mkDefault "start-hyprland";
    };

    plymouth = {
      enable = lib.mkDefault true;
    };
  };
}
