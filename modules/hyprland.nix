{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprland;
in
{
  options.ozzie.workstation.hyprland = {
    enable = lib.mkEnableOption "opinionated hyprland config";
  };

  config = lib.mkIf cfg.enable {
    ozzie.appearance.wallpaper.svg = lib.mkDefault ./hyprland.svg;

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}
