{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) hyprland;

  cfg = config.ozzie.workstation.hyprpolkitagent;
in
{
  config = lib.mkIf cfg.enable {

    wayland.windowManager.hyprland = lib.mkIf hyprland.enable {
      settings.exec-once = [
        "systemctl --user start hyprpolkitagent"
      ];
    };
  };
}
