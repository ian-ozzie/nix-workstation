{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.ly;
in
{
  options.ozzie.workstation.ly = {
    enable = lib.mkEnableOption "opinionated ly config";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
    };
  };
}
