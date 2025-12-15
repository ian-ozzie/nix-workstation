{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.printing;
in
{
  options.ozzie.workstation.printing = {
    enable = lib.mkEnableOption "opinionated printing config";
  };

  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;

      drivers = with pkgs; [
        cups-browsed
        cups-filters
      ];
    };
  };
}

