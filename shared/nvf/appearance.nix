{
  config,
  lib,
  ...
}:
let
  preset =
    {
      "" = { };

      catppuccin-mocha = {
        name = "catppuccin";
        style = "mocha";
      };

      rose-pine = {
        name = "rose-pine";
        style = "main";
      };

      solarized-dark = {
        name = "solarized";
        style = "dark";
      };

      solarized-osaka = {
        name = "solarized-osaka";
      };

      tokyo-night = {
        name = "tokyonight";
        style = "night";
      };
    }
    .${toString (config.ozzie.appearance.preset or null)};
in
{
  programs.nvf.settings.vim.theme = lib.mkIf (preset != { }) (
    {
      enable = true;
      transparent = lib.mkDefault false;
    }
    // preset
  );
}
