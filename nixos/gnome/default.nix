{
  pkgs,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      nerdfonts
    ];
  };

  services = {
    thermald.enable = true;
    uptimed.enable = true;

    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      enable = true;
    };
  };
}
