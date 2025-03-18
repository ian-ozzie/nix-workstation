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
    thermald.enable = true;
    uptimed.enable = true;

    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      enable = true;
    };
  };
}
