{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation;
in
{
  options.ozzie.workstation.preset = lib.mkOption {
    default = "catppuccin-mocha";
    description = "Preset extended colourscheme";

    type = lib.types.enum [
      "none"

      "catppuccin-mocha"
      "rose-pine"
      "solarized-dark"
      "solarized-osaka"
      "tokyo-night"
    ];
  };

  config = {
    ozzie.workstation.theme =
      {
        none = { };

        catppuccin-mocha = {
          polarity = lib.mkDefault "dark";

          base16 = {
            scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
            accent = lib.mkDefault "magenta";
          };

          colours = {
            accent = lib.mkDefault "#cba6f7";
            alert = lib.mkDefault "#d20f39";
            base = lib.mkDefault "#11111b";
            highlight = lib.mkDefault "#791aea";
            lowlight = lib.mkDefault "#1e1e2e";
          };
        };

        rose-pine = {
          polarity = lib.mkDefault "dark";

          base16 = {
            scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
            accent = lib.mkDefault "blue";
          };

          colours = {
            accent = lib.mkDefault "#eb6f92";
            alert = lib.mkDefault "#f6c177";
            base = lib.mkDefault "#191724";
            highlight = lib.mkDefault "#8a0f32";
            lowlight = lib.mkDefault "#26233a";
          };
        };

        solarized-dark = {
          polarity = lib.mkDefault "dark";

          base16 = {
            scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
            accent = lib.mkDefault "cyan";
          };

          colours = {
            accent = lib.mkDefault "#2aa198";
            alert = lib.mkDefault "#dc322f";
            base = lib.mkDefault "#00191f";
            highlight = lib.mkDefault "#00438d";
            lowlight = lib.mkDefault "#002b36";
          };
        };

        solarized-osaka = {
          polarity = lib.mkDefault "dark";

          base16 = {
            scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
            accent = lib.mkDefault "cyan";
          };

          colours = {
            accent = lib.mkDefault "#2aa198";
            alert = lib.mkDefault "#dc322f";
            base = lib.mkDefault "#00191f";
            highlight = lib.mkDefault "#00438d";
            lowlight = lib.mkDefault "#002b36";
          };
        };

        tokyo-night = {
          polarity = lib.mkDefault "dark";

          base16 = {
            scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
            accent = lib.mkDefault "blue";
          };

          colours = {
            accent = lib.mkDefault "#7aa2f7";
            alert = lib.mkDefault "#f7768e";
            base = lib.mkDefault "#15161e";
            highlight = lib.mkDefault "#0d4fdb";
            lowlight = lib.mkDefault "#1a1b26";
          };
        };
      }
      ."${cfg.preset}";
  };
}
