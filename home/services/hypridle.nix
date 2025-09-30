{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hypridle;
in
{
  options.ozzie.workstation.hypridle = {
    enable = lib.mkEnableOption "opinionated hypridle config";
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      package = with pkgs; hypridle;
    };
  };
}
