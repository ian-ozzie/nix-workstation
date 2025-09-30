{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprpaper;
in
{
  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      settings = {
        splash = false;
      };
    };
  };
}
