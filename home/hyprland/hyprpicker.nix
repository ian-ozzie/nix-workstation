{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) hyprland;

  cfg = config.ozzie.workstation.hyprpicker;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = lib.mkIf hyprland.enable {
      settings = lib.mkIf hyprland.binds {
        bind = [
          "$altMod $shiftMod, 1, exec, hyprpicker -alf hex"
          "$altMod $shiftMod $ctrlMod, 1, exec, hyprpicker -alf rgb"
        ];
      };
    };
  };
}
