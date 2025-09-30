{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.wlogout;
in
{
  options.ozzie.workstation.wlogout = {
    enable = lib.mkEnableOption "opinionated wlogout config";
  };

  config = lib.mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
      package = with pkgs; wlogout;
    };
  };
}
