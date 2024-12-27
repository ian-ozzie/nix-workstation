{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    appimage-run
    firefox
    kitty
    webkitgtk_6_0
  ];

  programs.hyprland = {
    enable = true;
    package = with pkgs; hyprland;
    portalPackage = with pkgs; xdg-desktop-portal-hyprland;
  };

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    xserver.enable = false;
  };
}
