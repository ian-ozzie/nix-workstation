{
  pkgs,
  ...
}:
{
  services.hypridle = {
    enable = true;
    package = with pkgs; hypridle;

    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          on-timeout = "hyprlock";
          timeout = 300;
        }
        {
          on-resume = "hyprctl dispatch dpms on";
          on-timeout = "hyprctl dispatch dpms off";
          timeout = 600;
        }
      ];
    };
  };
}
