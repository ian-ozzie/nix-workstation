{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.tofi;
in
{
  options.ozzie.workstation.tofi = {
    enable = lib.mkEnableOption "opinionated tofi config";
  };

  config = lib.mkIf cfg.enable {
    programs.tofi = {
      enable = true;
      package = with pkgs; tofi;
    };
  };
}
