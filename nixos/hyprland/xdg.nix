{
  pkgs,
  ...
}:
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      configPackages = with pkgs; [
        xdg-desktop-portal-hyprland
      ];

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}
