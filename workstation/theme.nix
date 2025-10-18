{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation) preset theme;

  resolution = "${toString theme.wallpaper.width}x${toString theme.wallpaper.height}";
in
{
  options.ozzie.workstation.theme = {
    base16 = {
      scheme = lib.mkOption {
        description = "Base16 colour scheme";
        type = lib.types.str;
      };

      accent = lib.mkOption {
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
        description = "Accent colour";
        type = lib.types.str;
      };

      alert = lib.mkOption {
        description = "Alert colour";
        type = lib.types.str;
      };

      base = lib.mkOption {
        description = "Base colour";
        type = lib.types.str;
      };

      highlight = lib.mkOption {
        description = "Highlight colour";
        type = lib.types.str;
      };

      lowlight = lib.mkOption {
        description = "Lowlight colour";
        type = lib.types.str;
      };
    };

    nerd-font = {
      name = lib.mkOption {
        default = "DejaVuSansM Nerd Font";
        description = "Nerd font name";
        type = lib.types.str;
      };

      package = lib.mkPackageOption pkgs.nerd-fonts "dejavu-sans-mono" { } // {
        description = "Nerd font package";
      };

      ttf = lib.mkOption {
        default = "${pkgs.nerd-fonts.dejavu-sans-mono}/share/fonts/truetype/NerdFonts/DejaVuSansM/DejaVuSansMNerdFontMono-Regular.ttf";
        description = "Path to nerd font TTF for direct reference";
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

    wallpaper = {
      height = lib.mkOption {
        default = 1600;
        description = "Width to generate to";
        type = lib.types.int;
      };

      png = lib.mkOption {
        description = "Wallpaper to use";
        type = lib.types.path;

        default = pkgs.stdenv.mkDerivation {
          name = "generated-wallpaper-${preset}-${resolution}.png";
          src = theme.wallpaper.svg;
          unpackPhase = "true";

          buildInputs = with pkgs; [
            gnused
            imagemagick
          ];

          buildPhase = ''
            cat $src \
            | sed -e 's/#11111b/${theme.colours.base}/g' \
            | sed -e 's/#1e1e2e/${theme.colours.lowlight}/g' \
            | sed -e 's/#791aea/${theme.colours.highlight}/g' \
            | sed -e 's/#cba6f7/${theme.colours.accent}/g' \
            > wallpaper.svg;

            magick wallpaper.svg -resize ${resolution} -gravity center -background "${theme.colours.base}" -extent ${resolution} wallpaper.png
          '';

          installPhase = ''
            install -Dm0644 wallpaper.png $out
          '';
        };
      };

      svg = lib.mkOption {
        default = ./wallpaper.svg;
        description = "Wallpaper to generate from";
        type = lib.types.path;
      };

      width = lib.mkOption {
        default = 3440;
        description = "Width to generate to";
        type = lib.types.int;
      };
    };
  };
}
