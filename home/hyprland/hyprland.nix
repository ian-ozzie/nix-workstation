{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation.theme) colours;

  base = lib.strings.removePrefix "#" colours.base;
  highlight = lib.strings.removePrefix "#" colours.highlight;
  lowlight = lib.strings.removePrefix "#" colours.lowlight;

  cfg = config.ozzie.workstation.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    stylix.targets.hyprland.enable = false;

    home.file.".bin/hyprland-adjust-zoom.sh" = {
      executable = true;
      text = builtins.readFile ./scripts/hyprland-adjust-zoom.sh;
    };

    wayland.windowManager.hyprland = {
      settings = {
        animations = {
          enabled = true;

          animation = [
            "border, 1, 2, default"
            "borderangle, 1, 2, default"
            "fade, 1, 2, default"
            "windows, 1, 2, myCurve"
            "windowsOut, 1, 2, default, popin 80%"
            "workspaces, 1, 2, default"
          ];

          bezier = [
            "myCurve, 0.05, 0.95, 0.2, 1"
          ];
        };

        binds = {
          hide_special_on_workspace_change = true;
          scroll_event_delay = 50;
          workspace_center_on = 1;
        };

        cursor = {
          hide_on_key_press = true;
          persistent_warps = false;
          warp_on_change_workspace = 1;
          warp_on_toggle_special = 1;
        };

        decoration = {
          active_opacity = 1.0;
          inactive_opacity = 0.9;
          rounding = 0;

          blur = {
            enabled = false;
          };

          shadow = {
            color = "rgb(${highlight})";
            enabled = true;
            range = 4;
            render_power = 3;
          };
        };

        dwindle = {
          preserve_split = true;
          pseudotile = true;
        };

        ecosystem = {
          no_donation_nag = true;
        };

        env = [
          "CLUTTER_BACKEND, wayland"
          "GDK_BACKEND, wayland,x11,*"
          "GDK_SCALE, 1"
          "MOZ_ENABLE_WAYLAND, 1"
          "NIXOS_OZONE_WL, 1"
          "NIXPKGS_ALLOW_UNFREE, 1"
          "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
          "QT_QPA_PLATFORM, wayland;xcb"
          "QT_SCALE_FACTOR, 1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
          "SDL_VIDEODRIVER, wayland"
          "XDG_CURRENT_DESKTOP, Hyprland"
          "XDG_SESSION_DESKTOP, Hyprland"
          "XDG_SESSION_TYPE, wayland"
        ];

        exec-once = [
          "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];

        general = {
          "col.active_border" = "rgb(${highlight})";
          "col.inactive_border" = "rgb(${lowlight})";
          allow_tearing = false;
          border_size = 1;
          gaps_in = 0;
          gaps_out = 0;
          layout = "scrolling";
          resize_on_border = false;
        };

        gesture = [
          "3, horizontal, workspace"
        ];

        input = {
          follow_mouse = 1;
          kb_layout = "us";
          repeat_delay = 200;
          repeat_rate = 40;
          sensitivity = lib.mkDefault 0.3;

          kb_options = [
            "caps:super"
          ];

          touchpad = {
            disable_while_typing = true;
            natural_scroll = true;
            scroll_factor = 1.0;
          };
        };

        misc = {
          background_color = "rgb(${base})";
          disable_hyprland_logo = true;
          force_default_wallpaper = 1;
          key_press_enables_dpms = true;
          mouse_move_enables_dpms = true;
        };

        scrolling = {
          explicit_column_widths = lib.mkDefault "0.2, 0.333, 0.5, 0.667, 0.8, 1.0";
          follow_min_visible = lib.mkDefault 0.0;
        };

        windowrule = [
          {
            name = "Smart borders";
            "match:workspace" = "w[tv1]";

            border_size = 0;
            float = "off";
            rounding = 0;
          }

          {
            name = "Dialogs";
            "match:tag" = "dialog";

            float = "on";
            move = "max(min(cursor_x-(window_w*0.5)\,(monitor_w-window_w-2))\,2) max(min(cursor_y-(window_h*0.5)\,(monitor_h-window_h-2))\,28)";
            no_screen_share = "on";
            pin = "on";
          }

          {
            name = "Dialog apps";
            "match:initial_class" = "(?i)browsers";

            tag = "+dialog";
          }

          {
            name = "Dialog file handlers";
            "match:title" = "(?i).*((load|open|save|export) (file|as|image)).*";

            size = "960 640";
            tag = "+dialog";
          }

          {
            name = "Float apps";
            "match:initial_class" = "(?i)(1password|bitwarden|librewolf)";

            float = "on";
          }

          {
            name = "Fullscreen apps";
            "match:initial_class" = "(?i)(kodi|steam_app_default)";

            fullscreen = "on";
          }

          {
            name = "Picture in Picture";
            "match:title" = "Picture-in-Picture";

            float = "on";
            move = "(monitor_w-656) (monitor_h-376)";
            size = "640 360";
          }

          {
            name = "Private apps";
            "match:initial_class" = "(?i)(1password|bitwarden|librewolf)";

            no_screen_share = "on";
          }
        ];
      };

      systemd = {
        enable = true;
        enableXdgAutostart = true;
        variables = [ "--all" ];
      };
    };
  };
}
