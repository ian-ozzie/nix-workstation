{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    xdg = {
      configFile."electron-flags.conf".text = ''
        --enable-features=PortalFileDialog
      '';

      portal.config = {
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
        };
      };
    };
  };
}
