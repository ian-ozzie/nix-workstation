{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie) appearance;
  inherit (config.ozzie.theme) colours wallpaper;

  cfg = config.ozzie.workstation.noctalia-greeter;
in
{
  options.ozzie.workstation.noctalia-greeter = {
    enable = lib.mkEnableOption "opinionated noctalia-greeter config";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = [ appearance.fonts.sansSerif.package ];

    services.displayManager.noctalia-greeter = {
      enable = true;

      cursorTheme = {
        inherit (appearance.cursor) package name;
      };

      settings = {
        cursor.size = appearance.cursor.size;

        appearance = {
          font_family = appearance.fonts.sansSerif.name;
          scheme = "Synced";
          theme_mode = appearance.polarity;

          palette = {
            error = colours.alert;
            hover = colours.accent;
            on_error = colours.alert;
            on_hover = colours.base;
            on_primary = colours.base;
            on_secondary = colours.text;
            on_surface = colours.text;
            on_surface_variant = colours.text;
            on_tertiary = colours.base;
            outline = colours.highlight;
            primary = colours.accent;
            secondary = colours.highlight;
            shadow = colours.base;
            surface = colours.base;
            surface_variant = colours.lowlight;
            tertiary = colours.accent;
          };

          wallpaper = {
            fill_color = colours.base;
            fill_mode = "crop";
            path = toString wallpaper;
          };
        };
      };
    };
  };
}
