{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie) theme;

  cfg = config.ozzie.workstation.regreet;
in
{
  options.ozzie.workstation.regreet = {
    enable = lib.mkEnableOption "opinionated regreet config";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.regreet = {
      enable = true;

      cursorTheme = {
        inherit (config.ozzie.appearance.cursor) package name;
      };

      extraCss = ''
        @define-color accent_bg_color ${theme.colours.accent};
        @define-color accent_color ${theme.colours.accent};
        @define-color accent_fg_color ${theme.colours.base};
        @define-color border_color ${theme.colours.highlight};
        @define-color destructive_color ${theme.colours.alert};
        @define-color view_bg_color ${theme.colours.lowlight};
        @define-color view_fg_color ${theme.colours.text};
        @define-color window_bg_color ${theme.colours.base};
        @define-color window_fg_color ${theme.colours.text};

        window {
          background-color: @window_bg_color;
          color: @window_fg_color;
        }

        frame.background, popover > contents {
          background-color: @view_bg_color;
          border-radius: 0;
          border: 1px solid @border_color;
          box-shadow: 0 8px 24px alpha(@window_bg_color, 0.5);
          color: @view_fg_color;
        }

        entry, button {
          background-color: @window_bg_color;
          background-image: none;
          border-radius: 0;
          border: 1px solid @border_color;
          box-shadow: none;
          color: @window_fg_color;
        }

        button:hover, button:checked {
          border-color: @accent_color;

          background-color: mix(
            @window_bg_color,
            @accent_bg_color,
            0.2
          );
        }

        entry:focus-within, button:focus-visible {
          border-color: @accent_color;
          outline-offset: 2px;
          outline: 2px solid alpha(@accent_color, 0.5);
        }

        button.suggested-action {
          background-color: @accent_bg_color;
          border-color: @accent_color;
          color: @accent_fg_color;
        }

        button.suggested-action:hover {
          background-color: shade(@accent_bg_color, 0.9);
        }

        button.destructive-action {
          border-color: @destructive_color;
          color: @destructive_color;
        }

        selection {
          background-color: @accent_bg_color;
          color: @accent_fg_color;
        }

        row:selected {
          background-color: alpha(@accent_bg_color, 0.2);
        }

        button:disabled {
          opacity: 0.45;
        }
      '';

      font = {
        inherit (config.ozzie.appearance.fonts.sansSerif) package name;
        size = 14;
      };

      settings = {
        GTK.application_prefer_dark_theme = config.ozzie.appearance.polarity == "dark";

        background = {
          path = toString theme.wallpaper;
          fit = "Cover";
        };
      };
    };
  };
}
