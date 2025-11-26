{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) hyprland;

  cfg = config.ozzie.workstation.pcmanfm;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = lib.mkIf hyprland.enable {
      settings = lib.mkIf hyprland.binds {
        bind = [
          "$mainMod, E, exec, pcmanfm"
        ];
      };
    };
  };
}
