{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprpolkitagent;
in
{
  options.ozzie.workstation.hyprpolkitagent = {
    enable = lib.mkEnableOption "opinionated hyprpolkitagent config";
  };

  config = lib.mkIf cfg.enable {
    services.hyprpolkitagent = {
      enable = true;
      package = with pkgs; hyprpolkitagent;
    };
  };
}
