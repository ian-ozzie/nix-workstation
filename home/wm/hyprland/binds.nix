{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) hyprland;
  inherit (hyprland) mainMod altMod ctrlMod shiftMod;
in
{
  config = {
    wayland.windowManager.hyprland = lib.mkIf hyprland.enable {
      settings = lib.mkIf hyprland.binds {
        bind = [
          "${altMod}, F4, killactive"
          "${altMod} ${shiftMod}, F4, forcekillactive"
          "${altMod} ${shiftMod} ${ctrlMod}, F4, exit"

          "${mainMod}, code:49, focuscurrentorlast" # code:49 = `
          "${mainMod} ${shiftMod}, code:49, focusurgentorlast" # code:49 = `
          "${mainMod}, F, togglefloating"
          "${mainMod} ${shiftMod}, F, fullscreen"
          "${mainMod}, P, pseudo"
          "${mainMod}, code:34, layoutmsg, focus l" # code:34 = [
          "${mainMod} ${shiftMod}, code:34, layoutmsg, swapcol l" # code:34 = [
          "${mainMod}, code:35, layoutmsg, focus r" # code:35 = ]
          "${mainMod} ${shiftMod}, code:35, layoutmsg, swapcol r" # code:35 = ]
          "${mainMod}, code:51, layoutmsg, promote" # code:51 = \

          # Move layout focus with mainMod + vim keys
          "${mainMod}, H, layoutmsg, focus l"
          "${mainMod} ${shiftMod}, H, layoutmsg, swapcol l"
          "${mainMod}, L, layoutmsg, focus r"
          "${mainMod} ${shiftMod}, L, layoutmsg, swapcol r"
          "${mainMod}, K, layoutmsg, focus u"
          "${mainMod} ${shiftMod}, K, layoutmsg, swapcol u"
          "${mainMod}, J, layoutmsg, focus d"
          "${mainMod} ${shiftMod}, J, layoutmsg, swapcol d"

          # Move focus with mainMod + arrow keys
          "${mainMod}, left, movefocus, l"
          "${mainMod}, right, movefocus, r"
          "${mainMod}, up, movefocus, u"
          "${mainMod}, down, movefocus, d"

          # Zoom hyprland
          "${mainMod}, mouse:274, exec, hyprctl keyword cursor:zoom_factor 1"
          "${mainMod}, mouse_down, exec, hyprctl getoption cursor:zoom_factor | grep float | awk '{ system(\"hyprctl keyword cursor:zoom_factor \" $2 * 1.1) }'"
          "${mainMod}, mouse_up, exec, hyprctl getoption cursor:zoom_factor | grep float | awk '{ if($2!=1) system(\"hyprctl keyword cursor:zoom_factor \" $2 * 0.9) }'"

          # Increase window size
          "${mainMod}, equal, layoutmsg, colresize +conf"
          "${mainMod}, minus, layoutmsg, colresize -conf"

          # Scratchpad workspace
          "${mainMod}, S, togglespecialworkspace, magic"
          "${mainMod} ${shiftMod}, S, movetoworkspace, special:magic"
          "${mainMod} ${shiftMod} ${ctrlMod}, S, movetoworkspacesilent, special:magic"
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
                "${mainMod}, ${key}, workspace, ${workspace}"
                "${mainMod} ${shiftMod}, ${key}, movetoworkspace, ${workspace}"
                "${mainMod} ${shiftMod} ${ctrlMod}, ${key}, movetoworkspacesilent, ${workspace}"
              ]
            ) (lib.lists.range 1 10)
          )
        );

        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          "${mainMod}, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          "${mainMod}, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          "${mainMod}, XF86MonBrightnessUp, exec, brightnessctl set 1%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
          "${mainMod}, XF86MonBrightnessDown, exec, brightnessctl set 1%-"
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
          "${mainMod}, mouse:272, resizewindow"
          "${mainMod} ${shiftMod}, mouse:272, movewindow"
          "${mainMod}, mouse:273, movewindow"
        ];
      };
    };
  };
}
