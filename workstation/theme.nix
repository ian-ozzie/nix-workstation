{
  lib,
  pkgs,
  ...
}:
{
  options.ozzie.workstation.theme = {
    base16 = {
      scheme = lib.mkOption {
        default = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        description = "Base16 colour scheme";
        type = lib.types.str;
      };

      accent = lib.mkOption {
        default = "magenta";
        description = "Base16 colour scheme accent";

        type = lib.types.enum [
          "black"
          "blue"
          "cyan"
          "green"
          "magenta"
          "red"
          "white"
          "yellow"
        ];
      };
    };

    colours = {
      accent = lib.mkOption {
        default = "#cba6f7";
        description = "Accent colour";
        type = lib.types.str;
      };

      alert = lib.mkOption {
        default = "#d20f39";
        description = "Alert colour";
        type = lib.types.str;
      };

      highlight = lib.mkOption {
        default = "#791aea";
        description = "Highlight colour";
        type = lib.types.str;
      };

      lowlight = lib.mkOption {
        default = "#1e1e2e";
        description = "Lowlight colour";
        type = lib.types.str;
      };
    };

    polarity = lib.mkOption {
      default = "dark";
      description = "Light/dark theme";

      type = lib.types.enum [
        "light"
        "dark"
      ];
    };
  };
}
