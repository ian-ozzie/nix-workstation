{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprpicker;
in
{
  options.ozzie.workstation.hyprpicker = {
    enable = lib.mkEnableOption "opinionated hyprpicker config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpicker
    ];
  };
}
