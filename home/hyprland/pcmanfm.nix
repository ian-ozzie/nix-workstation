{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.pcmanfm;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, E, exec, pcmanfm"
    ];
  };
}
