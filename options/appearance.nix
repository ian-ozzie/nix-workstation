{
  config,
  lib,
  pkgs,
  ...
}:
let
  presets = import ./presets.nix { inherit pkgs; };
in
{
  options.ozzie.appearance = {
    cursor = {
      name = lib.mkOption {
        default = "phinger-cursors-light";
        description = "the cursor theme's name";
        type = lib.types.str;
      };

      package = lib.mkOption {
        default = pkgs.phinger-cursors;
        description = "the package the cursor theme's name is in";
        type = lib.types.package;
      };

      size = lib.mkOption {
        default = 24;
        description = "cursor size in pixels";
        type = lib.types.int;
      };
    };

    fonts = {
      monospace = {
        package = lib.mkPackageOption pkgs.nerd-fonts "dejavu-sans-mono" { };

        name = lib.mkOption {
          default = "DejaVuSansM Nerd Font";
          description = "the monospace font's name, as fontconfig expects it";
          type = lib.types.str;
        };

        ttf = lib.mkOption {
          default = "${pkgs.nerd-fonts.dejavu-sans-mono}/share/fonts/truetype/NerdFonts/DejaVuSansM/DejaVuSansMNerdFontMono-Regular.ttf";
          description = "path to the monospace TTF file for direct reference";
          type = lib.types.str;
        };
      };

      sansSerif = {
        package = lib.mkPackageOption pkgs "dejavu_fonts" { };

        name = lib.mkOption {
          default = "DejaVu Sans";
          description = "the sans-serif font's name, as fontconfig expects it";
          type = lib.types.str;
        };
      };
    };

    polarity = lib.mkOption {
      description = "light/dark theme";

      default =
        if config.ozzie.appearance.preset == null then
          "dark"
        else
          presets.${config.ozzie.appearance.preset}.polarity;

      type = lib.types.enum [
        "dark"
        "light"
      ];
    };

    preset = lib.mkOption {
      default = "catppuccin-mocha";

      type = lib.types.nullOr (
        lib.types.enum [
          "catppuccin-mocha"
          "rose-pine"
          "solarized-dark"
          "solarized-osaka"
          "tokyo-night"
        ]
      );
    };

    wallpaper = {
      height = lib.mkOption {
        default = 1600;
        description = "height to generate to";
        type = lib.types.int;
      };

      svg = lib.mkOption {
        default = ./wallpaper.svg;
        description = "wallpaper to generate from";
        type = lib.types.path;
      };

      width = lib.mkOption {
        default = 3440;
        description = "width to generate to";
        type = lib.types.int;
      };
    };
  };
}
