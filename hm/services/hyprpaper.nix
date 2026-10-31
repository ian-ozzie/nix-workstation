{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprpaper;
in
{
  options.ozzie.workstation.hyprpaper = {
    enable = lib.mkEnableOption "opinionated hyprpaper config";
  };

  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      package = with pkgs; hyprpaper;
    };
  };
}
