{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    libnotify
  ];

  services.swaync = {
    enable = true;
    package = with pkgs; swaynotificationcenter;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
    };
  };
}
