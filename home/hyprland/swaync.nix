{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) hyprland;
  inherit (config.ozzie.workstation.theme.colours)
    accent
    alert
    base
    highlight
    lowlight
    ;

  text = "#${config.lib.stylix.colors.base05}";
  cfg = config.ozzie.workstation.swaync;
in
{
  config = lib.mkIf cfg.enable {
    stylix.targets.swaync.enable = false;

    services.swaync = {
      settings = {
        control-center-width = 400;
        layer = "overlay";
        notification-window-width = 400;
        positionX = "right";
        positionY = "top";

        widget-config = {
          buttons-grid = {
            actions = [
              {
                label = "󰐥";
                command = "systemctl poweroff";
              }
              {
                label = "󰜉";
                command = "systemctl reboot";
              }
              {
                label = "󰌾";
                command = "hyprlock --immediate";
              }
              {
                label = "󰍃";
                command = "hyprctl dispatch exit";
              }
              {
                label = "󰖩";
                command = "iwgtk";
              }
              {
                label = "󰂯";
                command = "blueman-manager";
              }
              {
                label = "";
                command = "kooha";
              }
            ];
          };

          title = {
            button-text = "";
            clear-all-button = true;
            text = "Notifications";
          };
        };
      };

      style = ''
        @define-color accent ${accent};
        @define-color alert ${alert};
        @define-color base ${base};
        @define-color highlight ${highlight};
        @define-color lowlight ${lowlight};
        @define-color text ${text};

        * {
          all: unset;
          font-family: "${config.ozzie.workstation.theme.nerd-font.name}";
          font-size: ${toString config.stylix.fonts.sizes.desktop}pt;
          transition: 0.2s;
        }

        scale {
          margin: 0 8px;
        }

        scale trough {
          border-radius: 12px;
          margin: 0 8px;
          min-height: 8px;
          min-width: 40px;
        }

        trough {
          background-color: @highlight;
        }

        trough highlight {
          background: @accent;
        }

        trough slider {
          background-color: @lowlight;
          box-shadow: 0 0 2px rgba(0, 0, 0, 0.8);
          margin: -8px;
          transition: all 0.2s ease;
        }

        trough slider:hover {
          box-shadow: 0 0 2px rgba(0, 0, 0, 0.8), 0 0 8px @highlight;
        }

        /* notifications */
        .notification-background {
          background: @lowlight;
          box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px @accent;
          color: @accent;
          margin: 8px 8px 0 0;
          padding: 0;
        }

        .notification-background .notification {
          padding: 4px;
        }

        .notification-background .notification.critical {
          box-shadow: inset 0 0 8px 0 @alert;
        }

        .notification .notification-content {
          margin: 4px;
        }

        .notification .notification-content overlay {
          /* icons */
          -gtk-icon-size: 48px;
          margin: 4px;
        }

        .notification-content .summary {
          color: @accent;
        }

        .notification-content .time {
          color: @accent;
          font-size: 0.5em;
          margin-top: -2px;
          margin-right: 12px;
        }

        .notification-content .body {
          color: @text;
        }

        .notification > *:last-child > * {
          min-height: 3em;
        }

        .notification-background .close-button {
          background-color: @lowlight;
          border: 1px solid @accent;
          border-radius: 8px;
          color: @accent;
          margin: 8px;
          padding: 2px;
        }

        .notification-background .close-button:hover {
          background-color: @highlight;
        }

        .notification-background .close-button:active {
          background-color: @highlight;
        }

        .notification .notification-action {
          border-radius: 8px;
          box-shadow: inset 0 0 0 1px @accent;
          color: @accent;
          font-size: 0.2rem;
          margin: 4px;
          padding: 8px;
        }

        .notification .notification-action {
          background-color: @lowlight;
        }

        .notification .notification-action:hover {
          background-color: @highlight;
        }

        .notification .notification-action:active {
          background-color: @alert;
        }

        .notification.critical progress {
          background-color: @alert;
        }

        .notification.low progress,
        .notification.normal progress {
          background-color: @highlight;
        }

        .notification progress,
        .notification trough,
        .notification progressbar {
          border-radius: 12px;
          padding: 4px 0;
        }

        /* control center */
        .control-center {
          background-color: @base;
          border-left: 2px solid @accent;
          box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8);
          color: @accent;
          opacity: 0.8;
          padding: 8px;
        }

        .control-center:hover {
          opacity: 1.0;
        }

        .control-center .notification-background {
          box-shadow: inset 0 0 0 1px @accent;
          margin: 4px 8px;
        }

        .control-center .notification:hover .notification-content .time {
          margin-right: 28px;
        }

        .control-center .notification-background .notification.low {
          opacity: 0.8;
        }

        .control-center .widget-title > label {
          color: @accent;
          font-size: 1.3em;
          margin: 8px;
        }

        .control-center .widget-title button {
          background-color: @lowlight;
          border-radius: 8px;
          box-shadow: inset 0 0 0 1px @accent;
          color: @accent;
          margin: 8px;
          padding: 8px 12px 8px 8px;
        }

        .control-center .widget-title button:hover {
          background-color: @highlight;
        }

        .control-center .widget-title button:active {
          background-color: @alert;
        }

        .control-center .notification-group {
          margin-top: 8px;
        }

        .control-center .notification-group:focus .notification-background {
          background-color: @lowlight;
        }

        scrollbar slider {
          margin: -4px;
          opacity: 0.8;
        }

        scrollbar trough {
          margin: 2px 0;
        }

        /* dnd */
        .widget-dnd {
          border-radius: 8px;
          font-size: 1.1rem;
          margin: 8px;
        }

        .widget-dnd > switch {
          background: @lowlight;
          border: 1px solid @accent;
          border-radius: 8px;
          box-shadow: none;
          font-size: initial;
        }

        .widget-dnd > switch:checked {
          background: @highlight;
        }

        .widget-dnd > switch slider {
          background: @text;
          border-radius: 8px;
        }

        /* mpris */
        .widget-mpris-player {
          background: @lowlight;
          border-radius: 12px;
          color: @accent;
        }

        .mpris-overlay {
          background-color: @lowlight;
          opacity: 0.9;
          padding: 15px 10px;
        }

        .widget-mpris-album-art {
          -gtk-icon-size: 96px;
          border-radius: 12px;
          margin: 0 8px;
        }

        .widget-mpris-title {
          color: @accent;
          font-size: 1.2rem;
        }

        .widget-mpris-subtitle {
          color: @text;
          font-size: 1rem;
        }

        .widget-mpris button {
          border-radius: 12px;
          color: @accent;
          margin: 0 8px;
          padding: 2px;
        }

        .widget-mpris button image {
          -gtk-icon-size: 1.8rem;
        }

        .widget-mpris button:hover {
          background-color: @lowlight;
        }

        .widget-mpris button:active {
          background-color: @highlight;
        }

        .widget-mpris button:disabled {
          opacity: 0.5;
        }

        .widget-menubar > box > .menu-button-bar > button > label {
          font-size: 3rem;
          padding: 0.5rem 2rem;
        }

        .widget-menubar > box > .menu-button-bar > :last-child {
          color: @alert;
        }

        .power-buttons button:hover,
        .powermode-buttons button:hover,
        .screenshot-buttons button:hover {
          background: @lowlight;
        }

        .control-center .widget-label > label {
          color: @accent;
          font-size: 2rem;
        }

        .widget-buttons-grid {
          padding-top: 1rem;
        }

        .widget-buttons-grid > flowbox > flowboxchild > button label {
          font-size: 2.5rem;
        }

        .widget-volume {
          padding: 1rem 0;
        }

        .widget-volume label {
          color: #74c7ec;
          padding: 0 1rem;
        }

        .widget-volume trough highlight {
          background: #74c7ec;
        }

        .widget-backlight trough highlight {
          background: #f9e2af;
        }

        .widget-backlight label {
          font-size: 1.5rem;
          color: #f9e2af;
        }

        .widget-backlight .KB {
          padding-bottom: 1rem;
        }

        .image {
          padding-right: 0.5rem;
        }
      '';
    };

    wayland.windowManager.hyprland = lib.mkIf hyprland.enable {
      settings = lib.mkIf hyprland.binds {
        bind = [
          "$mainMod, N, exec, swaync-client -t -sw"
        ]
        ++ lib.optional (!hyprland.tinker) "$mainMod $shiftMod, N, exec, pkill swaync || swaync"
        ++ lib.optional hyprland.tinker "$mainMod $shiftMod $ctrlMod, N, exec, pkill swaync || GTK_DEBUG=interactive swaync";
      };
    };
  };
}
