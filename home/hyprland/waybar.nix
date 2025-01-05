{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.waybar;
in
{
  config = lib.mkIf cfg.enable {
    programs.waybar = {
      settings = [
        {
          layer = "top";
          position = "top";

          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];

          modules-right = [
            "idle_inhibitor"
            "pulseaudio"
            "network"
            "memory"
            "cpu"
            "temperature"
            "battery"
            "clock"
          ];

          battery = {
            format = "{icon}   {capacity}%";
            format-alt = "{icon}   {power}W";
            format-charging = " {capacity}%";
            format-charging-full = " {capacity}%";
            format-full = "{icon}   {capacity}%";
            format-time = "{H}:{M:02}";
            interval = 60;
            tooltip = true;

            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];

            states = {
              warning = 30;
              critical = 15;
            };
          };

          clock = {
            format = "{:%H:%M}";
            interval = 60;
            tooltip = true;
            tooltip-format = "{:%Y-%m-%d}";
          };

          cpu = {
            format = "  {usage}%";
            format-alt = "  {load}";
            interval = 5;
            tooltip = true;

            states = {
              warning = 70;
              critical = 90;
            };
          };

          idle_inhibitor = {
            format = "{icon}";

            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };

          memory = {
            format = "󰍛 {percentage}%";
            format-alt = "󰍛 {used:0.2f}G/{total:0.2f}G";
            interval = 10;
            tooltip = true;

            states = {
              warning = 60;
              critical = 90;
            };
          };

          network = {
            format-disconnected = "No connection";
            format-ethernet = "  {ifname}";
            format-wifi = "   {signalStrength}%";
            interval = 10;
            tooltip = true;
            tooltip-format-ethernet = "{icon} {ifname} @ {ipaddr}/{cidr} via {gwaddr}";
            tooltip-format-wifi = "{icon} {essid} @ {ipaddr}/{cidr} via {gwaddr}";
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon}  {volume}%";
            format-muted = "";
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            scroll-step = 1;
            tooltip = true;

            format-icons = {
              headphone = " ";
              default = [
                " "
                " "
              ];
            };
          };

          temperature = {
            critical-threshold = 60;
            format = "{icon} {temperatureC}°";
            interval = 5;
            tooltip = false;

            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };
        }
      ];

      style = ''
        @define-color accent #cba6f7;
        @define-color alert #d20f39;
        @define-color highlight #791aea;
        @define-color lowlight #1e1e2e;

        * {
          border-radius: 0px;
          border: none;
          font-size: 16px;
        }

        window#waybar {
          background: @lowlight;
          border-bottom: 2px solid @accent;
          color: @accent;
        }

        .modules-left .module {
          border-right: 1px solid @accent;
          padding: 0 8px;
        }

        .modules-left >:last-child .module {
          border-right: 0;
        }

        .modules-right .module {
          border-left: 1px solid @accent;
          padding: 0 8px;
        }

        .modules-right >:first-child .module {
          border-left: 0;
        }

        window .modules-left #workspaces button {
          border: 0;
          color: @accent;
          font-weight: 400;
          padding: 4px 8px;
          transition: background 0.2s ease-in-out, color 0.2s ease-in-out;
        }

        window .modules-left #workspaces button:hover {
          background: @highlight;
          border-top: 0;
          box-shadow: inherit;
          text-shadow: inherit;
        }

        window .modules-left #workspaces button.focused,
        window .modules-left #workspaces button.active {
          background-color: @accent;
          border: 0;
          color: @lowlight;
          font-weight: 700;
        }

        window .modules-left #workspaces button.urgent {
          background-color: @alert;
        }
      '';
    };
  };
}
