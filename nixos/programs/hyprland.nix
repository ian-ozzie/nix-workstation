{
  config,
  lib,
  pkgs,
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
    programs.hyprland = {
      enable = true;
      package = with pkgs; hyprland;
      portalPackage = with pkgs; xdg-desktop-portal-hyprland;
    };
  };
}
