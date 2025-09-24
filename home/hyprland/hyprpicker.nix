{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.hyprpicker
  ];

  wayland.windowManager.hyprland.settings.bind = [
    "ALT SHIFT, 1, exec, hyprpicker -a -f hex"
    "CTRL ALT SHIFT, 1, exec, hyprpicker -a -f rgb"
  ];
}
