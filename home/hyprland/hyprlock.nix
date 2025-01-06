{
  pkgs,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    package = with pkgs; hyprlock;
  };
}
