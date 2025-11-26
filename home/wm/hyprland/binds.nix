{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) hyprland;
in
{
  config = {
    wayland.windowManager.hyprland = lib.mkIf hyprland.enable {
      settings = lib.mkIf hyprland.binds {
        general = {
          "$mainMod" = hyprland.mainMod;
          "$altMod" = hyprland.altMod;
          "$ctrlMod" = hyprland.ctrlMod;
          "$shiftMod" = hyprland.shiftMod;
        };

        bind = [
          "$altMod, F4, killactive"
          "$altMod $shiftMod, F4, forcekillactive"
          "$altMod $shiftMod $ctrlMod, F4, exit"

          "$mainMod, code:49, focusurgentorlast" # code:49 = `
          "$mainMod, F, togglefloating"
          "$mainMod $shiftMod, F, fullscreen"
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
          "$mainMod $shiftMod, S, movetoworkspace, special:magic"
          "$mainMod $shiftMod $ctrlMod, S, movetoworkspacesilent, special:magic"
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
                "$mainMod $shiftMod, ${key}, movetoworkspace, ${workspace}"
                "$mainMod $shiftMod $ctrlMod, ${key}, movetoworkspacesilent, ${workspace}"
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
          "$mainMod $shiftMod, mouse:272, movewindow"
          "$mainMod, mouse:273, movewindow"
        ];
      };
    };
  };
}
