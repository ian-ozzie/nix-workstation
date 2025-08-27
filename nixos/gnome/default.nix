{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    appimage-run
    firefox
    webkitgtk_6_0
  ];

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      nerd-fonts.dejavu-sans-mono
    ];
  };

  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    thermald.enable = true;
    uptimed.enable = true;
  };
}
