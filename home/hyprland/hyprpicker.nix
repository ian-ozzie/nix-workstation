{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprpicker;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.bind = [
      "ALT SHIFT, 1, exec, hyprpicker -alf hex"
      "CTRL ALT SHIFT, 1, exec, hyprpicker -alf rgb"
    ];
  };
}
