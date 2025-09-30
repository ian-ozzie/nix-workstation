{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprsunset;
in
{
  options.ozzie.workstation.hyprsunset = {
    enable = lib.mkEnableOption "opinionated hyprsunset config";
  };

  config = lib.mkIf cfg.enable {
    services.hyprsunset = {
      enable = true;
      package = with pkgs; hyprsunset;
    };
  };
}
