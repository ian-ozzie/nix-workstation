{
  pkgs,
  ...
}:
{
  services.hyprpolkitagent = {
    enable = true;
    package = pkgs.hyprpolkitagent;
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user start hyprpolkitagent"
  ];
}
