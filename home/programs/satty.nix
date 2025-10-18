{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.satty;
in
{
  options.ozzie.workstation.satty = {
    enable = lib.mkEnableOption "opinionated satty config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      satty
    ];
  };
}
