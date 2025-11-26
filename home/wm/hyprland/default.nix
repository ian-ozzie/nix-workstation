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
    tinker = lib.mkEnableOption "enables tinkering/debug flags";

    binds = lib.mkEnableOption "configures binds" // {
      default = cfg.enable;
    };

    mainMod = lib.mkOption {
      default = "SUPER";
      description = "main modifier key";
      type = lib.types.str;
    };

    altMod = lib.mkOption {
      default = "ALT";
      description = "alt modifier key";
      type = lib.types.str;
    };

    ctrlMod = lib.mkOption {
      default = "CTRL";
      description = "ctrl modifier key";
      type = lib.types.str;
    };

    shiftMod = lib.mkOption {
      default = "SHIFT";
      description = "shift modifier key";
      type = lib.types.str;
    };
  };

  imports = [
    ./binds.nix
  ];

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = with pkgs; hyprland;
      xwayland.enable = true;
    };
  };
}
