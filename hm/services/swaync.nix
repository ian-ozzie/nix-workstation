{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.swaync;
in
{
  options.ozzie.workstation.swaync = {
    enable = lib.mkEnableOption "opinionated swaync config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libnotify
    ];

    services.swaync = {
      enable = true;
      package = with pkgs; swaynotificationcenter;
    };
  };
}
