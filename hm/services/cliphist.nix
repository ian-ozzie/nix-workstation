{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.cliphist;
in
{
  options.ozzie.workstation.cliphist = {
    enable = lib.mkEnableOption "opinionated cliphist config";
  };

  config = lib.mkIf cfg.enable {
    services.cliphist = {
      allowImages = false;
      clipboardPackage = with pkgs; wl-clipboard;
      enable = true;
      package = with pkgs; cliphist;
    };
  };
}
