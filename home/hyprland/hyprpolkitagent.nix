{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprpolkitagent;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.exec-once = [
      "systemctl --user start hyprpolkitagent"
    ];
  };
}
