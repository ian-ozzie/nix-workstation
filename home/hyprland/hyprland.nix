{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme) colours;

  base = lib.strings.removePrefix "#" colours.base;
  highlight = lib.strings.removePrefix "#" colours.highlight;
  lowlight = lib.strings.removePrefix "#" colours.lowlight;
in
{
  stylix.targets.hyprland.enable = false;

  home.file.".bin/hyprland-adjust-zoom.sh" = {
    executable = true;
    text = builtins.readFile ./scripts/hyprland-adjust-zoom.sh;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = with pkgs; hyprland;
    xwayland.enable = true;

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

      bind = [
        "ALT, F4, killactive"
        "ALT SHIFT, F4, forcekillactive"
        "CTRL ALT SHIFT, F4, exit"

        "$mainMod, code:49, focusurgentorlast" # code:49 = `
        "$mainMod, F, togglefloating"
        "$mainMod SHIFT, F, fullscreen"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, code:34, cyclenext" # code:34 = [
        "$mainMod, code:35, cyclenext, prev" # code:35 = ]

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Zoom hyprland
        "$mainMod, mouse:274, exec, hyprctl keyword cursor:zoom_factor 1"
        "$mainMod, mouse_down, exec, hyprctl getoption cursor:zoom_factor | grep float | awk '{ system(\"hyprctl keyword cursor:zoom_factor \" $2 * 1.1) }'"
        "$mainMod, mouse_up, exec, hyprctl getoption cursor:zoom_factor | grep float | awk '{ if($2!=1) system(\"hyprctl keyword cursor:zoom_factor \" $2 * 0.9) }'"
        "$mainMod, equal, exec, hyprctl getoption cursor:zoom_factor | grep float | awk '{ system(\"hyprctl keyword cursor:zoom_factor \" $2 * 1.1) }'"
        "$mainMod, minus, exec, hyprctl getoption cursor:zoom_factor | grep float | awk '{ if($2!=1) system(\"hyprctl keyword cursor:zoom_factor \" $2 * 0.9) }'"

        # Scratchpad workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod CTRL SHIFT, S, movetoworkspacesilent, special:magic"
      ]
      ++ (
        # 0-9 workspace handling
        builtins.concatLists (
          map (
            x:
            let
              key = if x == 10 then "0" else toString x;
              workspace = toString x;
            in
            [
              "$mainMod, ${key}, workspace, ${workspace}"
              "$mainMod SHIFT, ${key}, movetoworkspace, ${workspace}"
              "$mainMod CTRL SHIFT, ${key}, movetoworkspacesilent, ${workspace}"
            ]
          ) (lib.lists.range 1 10)
        )
      );

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "$mainMod, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "$mainMod, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 1%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 1%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", F8, exec, playerctl play-pause"
      ];

      bindm = [
        "$mainMod, mouse:272, resizewindow"
        "$mainMod SHIFT, mouse:272, movewindow"
        "$mainMod, mouse:273, movewindow"
      ];

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
        "$mainMod" = "SUPER";
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
        "noscreenshare, class:1Password"
        "noscreenshare, class:Bitwarden"
        "noscreenshare, class:librewolf"
        "noscreenshare, tag:dialog"

        # File handling popups: Treat as dialog
        "size 960 640, title:^.*(Export Image|Location|Open|Progress|Save File|wants to save|wants to open).*$"
        "tag +dialog, title:^.*(Export Image|Location|Open|Progress|Save File|wants to save|wants to open).*$"

        # Kodi: Fullscreen
        "fullscreen, initialClass:Kodi"

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
}
