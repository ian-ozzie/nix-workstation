{
  pkgs,
  ...
}:
{
  programs.wlogout = {
    enable = true;
    package = with pkgs; wlogout;

    layout = [
      {
        action = "systemctl poweroff";
        keybind = "s";
        label = "shutdown";
        text = "Shutdown";
      }
      {
        action = "systemctl reboot";
        keybind = "r";
        label = "reboot";
        text = "Reboot";
      }
      {
        action = "hyprctl dispatch exit";
        keybind = "e";
        label = "logout";
        text = "Exit";
      }
      {
        action = "hyprlock";
        keybind = "l";
        label = "lock";
        text = "Lock";
      }
    ];
  };
}
