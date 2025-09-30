{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme) colours;

  accent = lib.strings.removePrefix "#" colours.accent;
  alert = lib.strings.removePrefix "#" colours.alert;
  highlight = lib.strings.removePrefix "#" colours.highlight;
  lowlight = lib.strings.removePrefix "#" colours.lowlight;

  hyprlock-now-playing = lib.getExe (
    pkgs.writeShellApplication {
      name = "hyprlock-now-playing";
      text = builtins.readFile ./scripts/hyprlock-now-playing.sh;

      runtimeInputs = with pkgs; [
        playerctl
      ];
    }
  );

  cfg = config.ozzie.workstation.hyprlock;
in
{
  config = lib.mkIf cfg.enable {
    stylix.targets.hyprlock.enable = false;

    programs.hyprlock = {
      settings = {
        background = {
          blur_passes = 2;
          color = "rgb(${lowlight})";
          path = lib.mkDefault config.stylix.image;
        };

        general = {
          grace = 5;
          hide_cursor = true;
          no_fade_in = true;
        };

        input-field = {
          check_color = "rgb(${highlight})";
          fail_color = "rgb(${alert})";
          font_color = "rgb(${accent})";
          hide_input = false;
          inner_color = "rgb(${lowlight})";
          outer_color = "rgb(${highlight})";
          outline_thickness = 2;
          size = "500, 100";
        };

        label = [
          {
            color = "rgb(${accent})";
            font_size = 72;
            halign = "center";
            position = "0, 200";
            text = "cmd[update:1000] date +'%-I:%M%p'";
            valign = "center";
          }
          {
            color = "rgb(${accent})";
            font_size = 24;
            halign = "center";
            position = "0, 300";
            text = "cmd[update:1000] date +'%A, %B %d'";
            valign = "center";
          }
          {
            color = "rgb(${accent})";
            font_size = 24;
            halign = "center";
            position = "0, 50";
            text = "cmd[update:1000] ${hyprlock-now-playing}";
            valign = "bottom";
          }
        ];
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, L, exec, hyprlock --immediate"
    ];
  };
}
