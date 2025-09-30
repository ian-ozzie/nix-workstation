{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.swappy;
in
{
  options.ozzie.workstation.swappy = {
    enable = lib.mkEnableOption "opinionated swappy config";
  };

  config = lib.mkIf cfg.enable {
    programs.swappy = {
      enable = true;
      package = with pkgs; swappy;
    };
  };
}
