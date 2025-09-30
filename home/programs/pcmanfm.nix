{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.pcmanfm;
in
{
  options.ozzie.workstation.pcmanfm = {
    enable = lib.mkEnableOption "opinionated pcmanfm config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pcmanfm
    ];
  };
}
