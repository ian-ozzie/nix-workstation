{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.hypridle;
in
{
  config = lib.mkIf cfg.enable {
    services.hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            on-timeout = "hyprlock --grace 5";
            timeout = 300;
          }
          {
            on-resume = "hyprctl dispatch dpms on";
            on-timeout = "hyprctl dispatch dpms off";
            timeout = 360;
          }
        ];
      };
    };
  };
}
