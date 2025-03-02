{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme) colours;

  highlight = lib.strings.removePrefix "#" colours.highlight;
  lowlight = lib.strings.removePrefix "#" colours.lowlight;
in
{
  stylix.targets.hyprland.enable = false;

  wayland.windowManager.hyprland = {
    enable = true;
    package = with pkgs; hyprland;
    systemd.enable = true;
    xwayland.enable = true;

    extraConfig = ''
      # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      workspace = w[tv1], gapsout:0, gapsin:0
      workspace = f[1], gapsout:0, gapsin:0
      windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
      windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
      windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
      windowrulev2 = rounding 0, floating:0, onworkspace:f[1]
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

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, W, exec, $browser"
        "$mainMod, E, exec, $explorer"
        "$mainMod, R, exec, $menu"
        "$mainMod SHIFT, B, exec, pkill $bar || $bar"

        "ALT, F4, killactive,"
        "ALT SHIFT, F4, exec, kill -9 $(hyprctl activewindow | grep pid | tail -1 | awk '{print$2}')"
        "CTRL ALT SHIFT, F4, exit,"

        "$mainMod, F, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        # Screenshots
        "ALT SHIFT, 1, exec, hyprpicker -a -f hex"
        "CTRL ALT SHIFT, 1, exec, hyprpicker -a -f rgb"
        "ALT SHIFT, 2, exec, hyprshot -m output -r stdout | swappy -f -"
        "ALT SHIFT, 3, exec, hyprshot -m window -r stdout | swappy -f -"
        "ALT SHIFT, 4, exec, hyprshot -m region -r stdout | swappy -f -"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindm = [
        "$mainMod, mouse:272, resizewindow"
        "$mainMod SHIFT, mouse:272, movewindow"
        "$mainMod, mouse:273, movewindow"
      ];

      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        rounding = 0;

        blur = {
          enabled = false;
        };

        shadow = {
          color = lib.mkForce "rgba(${highlight}ff)";
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };

      env = [
        "CLUTTER_BACKEND, wayland"
        "GDK_BACKEND, wayland, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "SDL_VIDEODRIVER, wayland"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
      ];

      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "brightnessctl set 0"
        "[workspace 1] $terminal"
        "[workspace 10 silent] $browser"
        "hyprpolkitagent"
        "$bar"
        "/home/ozzie/src/scripts/hyprland_handle_events.sh"
      ];

      general = {
        "$bar" = "waybar";
        "$browser" = "firefox";
        "$explorer" = "kitty -1 yazi";
        "$mainMod" = "SUPER";
        "$menu" = "tofi-drun --width 640 --height 360";
        "$terminal" = "kitty";
        "col.active_border" = lib.mkForce "rgba(${highlight}ff)";
        "col.inactive_border" = lib.mkForce "rgba(${lowlight}ff)";
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
        disable_hyprland_logo = true;
        force_default_wallpaper = 1;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
      };

      windowrulev2 = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
