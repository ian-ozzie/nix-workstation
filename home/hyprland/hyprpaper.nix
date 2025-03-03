{
  pkgs,
  ...
}:
{
  services.hyprpaper = {
    enable = true;
    package = with pkgs; hyprpaper;
  };
}
