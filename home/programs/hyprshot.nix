{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprshot;
in
{
  options.ozzie.workstation.hyprshot = {
    enable = lib.mkEnableOption "opinionated hyprshot config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprshot
    ];
  };
}
