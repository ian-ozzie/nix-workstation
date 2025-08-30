{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme.colours)
    accent
    alert
    highlight
    lowlight
    ;

  cfg = config.ozzie.workstation.waybar;
in
{
  config = lib.mkIf cfg.enable {
    stylix.targets.waybar.enable = false;

    home.file.".config/waybar/yubikey-waiting.sh" = {
      executable = true;
      text = builtins.readFile ./scripts/waybar-yubikey-waiting.sh;
    };

    programs.waybar = {
      settings = [
        {
          layer = "top";
          position = "top";

          modules-left = [
            "custom/logout"
            "hyprland/workspaces"
            "idle_inhibitor"
            "custom/yubikey"
            "hyprland/window"
          ];

          modules-right = [
            "tray"
            "pulseaudio"
            "network"
            "memory"
            "cpu"
            "temperature"
            "battery"
            "clock"
          ];

          battery = {
            format = "{icon}  {capacity}%";
            format-alt = "{icon}  {power}W";
            format-charging = " {capacity}%";
            format-charging-full = " {capacity}%";
            format-full = "{icon}  {capacity}%";
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
              warning = 15;
              critical = 5;
            };
          };

          clock = {
            format = "{:%H:%M}";
            interval = 60;
            tooltip = true;
            tooltip-format = "{:%Y-%m-%d}";
          };

          cpu = {
            format = " {usage}%";
            format-alt = " {load}";
            interval = 5;
            tooltip = true;

            states = {
              warning = 70;
              critical = 90;
            };
          };

          "custom/logout" = {
            format = "󰗽";
            on-click = "wlogout -b 4";
            tooltip = false;
          };

          "custom/yubikey" = {
            exec = "$XDG_CONFIG_HOME/waybar/yubikey-waiting.sh";
            return-type = "json";
          };

          "hyprland/window" = {
            expand = true;
            format = "{title}";
            icon = true;
            icon-size = 16;
            separate-outputs = true;
          };

          "hyprland/workspaces" = {
            cursor = true;
            disable-scroll = true;
            format = "{name} {windows}";
            format-window-separator = "";
            show-special = true;
            special-visible-only = true;
            window-rewrite-default = " ";
            window-rewrite = {
              "Bitwarden" = " ";
              "brave-browser" = " ";
              "firefox" = " ";
              "kitty" = " ";
              "librewolf" = " ";
              "obsidian" = " ";
              "pcmanfm" = " ";

              "1Password" = "󰢁 ";
              "Slack" = " ";
              "google-chrome" = " ";

              "Gimp-2.10" = " ";
              "Gimp-3.0" = " ";
              "OrcaSlicer" = "󰹜 ";
              "QIDISlicer" = "󰹜 ";
              "gimp" = " ";
              "openscad" = "󰻫 ";
              "org.inkscape.Inkscape" = " ";

              "Feishin" = " ";
              "Supersonic" = " ";
              "com.github.th_ch.youtube_music" = " ";
              "org.strawberrymusicplayer.strawberry" = "󰁧 ";

              "Kodi" = "󰤚 ";
              "LosslessCut" = "󱦩 ";
              "com.obsproject.Studio" = "󱜠 ";
              "vlc" = "󰕼 ";

              "discord" = " ";
              "epicgameslauncher.exe" = "󰊗 ";
              "net.lutris.Lutris" = " ";
              "steam" = " ";
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
            format-ethernet = " ";
            format-wifi = "  {signalStrength}%";
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

          tray = {
            expand = false;
            icon-size = 16;
            reverse-direction = true;
            spacing = 10;
          };
        }
      ];

      style = ''
        @define-color accent ${accent};
        @define-color alert ${alert};
        @define-color highlight ${highlight};
        @define-color lowlight ${lowlight};

        @keyframes pulse-alert { 10% { background-color: @alert; }}

        * {
          border-radius: 0px;
          border: none;
          font-family: "DejaVuSansM Nerd Font";
          font-size: 16px;
        }

        window#waybar {
          background: @lowlight;
          border-bottom: 2px solid @accent;
          color: @accent;
        }

        window .module {
          border-bottom: 2px solid @accent;
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

        window #battery {
          background-color: @lowlight;
          border-bottom: 2px solid @accent;
          font-size: 14px;
          transition: background 0.2s ease-in-out;
        }

        window #battery.warning.discharging {
          background-color: @alert;
        }

        window #battery.critical.charging {
          background-color: @alert;
        }

        window #battery.critical.discharging {
          animation: pulse-alert 5s infinite;
        }

        window #custom-logout {
          background-color: @lowlight;
          border-bottom: 2px solid @accent;
          transition: background 0.2s ease-in-out;
        }

        window #custom-logout:hover {
          background-color: @highlight;
          border-bottom: 2px solid @accent;
        }

        window #custom-yubikey {
          background-color: @lowlight;
          border-bottom: 2px solid @accent;
          color: @accent;
        }

        window #custom-yubikey.alert {
          animation: pulse-alert 5s infinite;
        }

        window #idle_inhibitor {
          background-color: @lowlight;
          border-bottom: 2px solid @accent;
          font-size: 14px;
          transition: background 0.2s ease-in-out;
        }

        window #idle_inhibitor:hover {
          background-color: @highlight;
        }

        window #idle_inhibitor.activated {
          background-color: @alert;
        }

        window #workspaces {
          padding: 0;
        }

        window #workspaces button {
          border-bottom-width: 0;
          border-left: 1px solid @accent;
          color: @accent;
          font-weight: 400;
          padding: 0 0 0 8px;
          transition: background 0.2s ease-in-out, color 0.2s ease-in-out;
        }

        window #workspaces button:first-child {
          border-left: 0;
        }

        window #workspaces button:hover {
          background: @highlight;
          border-top: 0;
          box-shadow: inherit;
          text-shadow: inherit;
        }

        window #workspaces button.focused,
        window #workspaces button.active {
          background-color: @accent;
          border-bottom-width: 0;
          color: @lowlight;
          font-weight: 700;
        }

        window #workspaces button.urgent {
          background-color: @lowlight;
          color: @accent;
          animation: pulse-alert 5s infinite;
        }
      '';
    };

    systemd.user = {
      services.yubikey-touch-detector = {
        Service.ExecStart = lib.getExe pkgs.yubikey-touch-detector;
        Unit.Description = "Yubikey Touch Detector daemon";
      };

      sockets.yubikey-touch-detector = {
        Install.WantedBy = [ "sockets.target" ];
        Unit.Description = "Yubikey Touch Detector daemon";

        Socket = {
          Accept = false;
          ListenStream = "%t/yubikey-touch-detector.socket";
          SocketMode = "0600";
        };
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "$mainMod SHIFT, B, exec, pkill waybar || waybar" ];
      exec-once = [ "waybar" ];
    };
  };
}
