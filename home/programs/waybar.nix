{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.waybar;
in
{
  options.ozzie.workstation.waybar = {
    enable = lib.mkEnableOption "opinionated waybar config";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      package = with pkgs; waybar;
    };
  };
}
