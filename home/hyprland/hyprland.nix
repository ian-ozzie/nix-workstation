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
      extraConfig = ''
        # Uncomment to have logs
        # debug:disable_logs = false

        # Ignore maximize requests from apps
        windowrule = suppressevent maximize, class:.*

        # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
        # "Smart gaps" / "No gaps when only"
        workspace = w[tv1], gapsout:0, gapsin:0
        workspace = f[1], gapsout:0, gapsin:0
        windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
        windowrule = rounding 0, floating:0, onworkspace:w[tv1]
        windowrule = bordersize 0, floating:0, onworkspace:f[1]
        windowrule = rounding 0, floating:0, onworkspace:f[1]
      '';

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
          layout = "dwindle";
          no_border_on_floating = false;
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

        windowrule = [
          # Browsers: Treat as dialog, let it control size
          "tag +dialog, initialClass:browsers"

          # CopyQ: Treat as dialog
          "size 640 480, initialClass:com.github.hluk.copyq"
          "tag +dialog, initialClass:com.github.hluk.copyq"

          # Disable screenshare on private windows
          "noscreenshare, class:librewolf"
          "noscreenshare, tag:dialog"

          # File handling popups: Treat as dialog
          "size 960 640, title:^.*(Export Image|Location|Open|Progress|Save File|wants to save|wants to open|Load SVG Image).*$"
          "tag +dialog, title:^.*(Export Image|Location|Open|Progress|Save File|wants to save|wants to open|Load SVG Image).*$"

          # Kodi: Fullscreen
          "fullscreen, initialClass:Kodi"

          # Password managers
          "float, class:1Password"
          "noscreenshare, class:1Password"
          "float, class:Bitwarden"
          "noscreenshare, class:Bitwarden"

          # Picture-in-Picture: Float bottom right
          "float, title:Picture-in-Picture"
          "move 100%-656 100%-376, title:Picture-in-Picture"
          "size 640 360, title:Picture-in-Picture"

          # Steam: Fullscreen games
          "fullscreen, initialClass:steam_app_default"
        ]
        ++ [
          # Tag rules
          # Dialog: Center under cursor
          "float, tag:dialog"
          "move onscreen cursor -50% -50%, tag:dialog"
          "pin, tag:dialog"
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
