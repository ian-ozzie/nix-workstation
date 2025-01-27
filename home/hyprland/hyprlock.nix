{
  pkgs,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    package = with pkgs; hyprlock;

    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };
    };
  };
}
