{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) hyprland;

  cfg = config.ozzie.workstation.hyprlauncher;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = lib.mkIf hyprland.enable {
      settings = lib.mkIf hyprland.binds {
        bind = [
          "$mainMod, R, exec, hyprlauncher"
        ];
      };
    };

    xdg.configFile."hypr/hyprlauncher.conf" = {
      text = ''
        general = {
          grab_focus = true
        }

        cache = {
          enabled = true
        }

        finders = {
          desktop_icons = true
        }

        ui {
          window_size = 640 360
        }
      '';
    };
  };
}
