{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprlock;
in
{
  options.ozzie.workstation.hyprlock = {
    enable = lib.mkEnableOption "opinionated hyprlock config";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      package = with pkgs; hyprlock;
    };
  };
}
