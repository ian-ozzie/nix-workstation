{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.theme;
  appearance = config.ozzie.appearance;
  resolution = "${toString appearance.wallpaper.width}x${toString appearance.wallpaper.height}";

  presets = import ./presets.nix { inherit pkgs; };
in
{
  options.ozzie.theme = {
    base16 = {
      scheme = lib.mkOption {
        description = "base16 colour scheme";
        type = lib.types.str;
      };

      accent = lib.mkOption {
        description = "base16 colour scheme accent";

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

    colours = lib.genAttrs [ "accent" "alert" "base" "highlight" "lowlight" "text" ] (
      name:
      lib.mkOption {
        description = "the ${name} colour";
        type = lib.types.str;
      }
    );

    wallpaper = lib.mkOption {
      description = "wallpaper image to use, default generated with colours from `ozzie.appearance.wallpaper.svg`";
      type = lib.types.path;

      default = pkgs.stdenv.mkDerivation {
        name = "generated-wallpaper-${toString appearance.preset}-${resolution}.png";
        src = appearance.wallpaper.svg;
        unpackPhase = "true";

        buildInputs = with pkgs; [
          gnused
          imagemagick
        ];

        buildPhase = ''
          cat $src \
          | sed -e 's/#11111b/${cfg.colours.base}/g' \
          | sed -e 's/#1e1e2e/${cfg.colours.lowlight}/g' \
          | sed -e 's/#791aea/${cfg.colours.highlight}/g' \
          | sed -e 's/#cba6f7/${cfg.colours.accent}/g' \
          > wallpaper.svg

          magick wallpaper.svg -resize ${resolution} -gravity center \
            -background "${cfg.colours.base}" -extent ${resolution} wallpaper.png
        '';

        installPhase = ''
          install -Dm0644 wallpaper.png $out
        '';
      };
    };
  };

  config.ozzie.theme = {
    base16 = lib.optionalAttrs (appearance.preset != null) (
      lib.mapAttrs (_: lib.mkDefault) presets.${appearance.preset}.base16
    );

    colours = lib.optionalAttrs (appearance.preset != null) (
      lib.mapAttrs (_: lib.mkDefault) presets.${appearance.preset}.colours
    );
  };
}
