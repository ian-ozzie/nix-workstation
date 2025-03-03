{
  config,
  inputs,
  pkgs,
  ...
}:
let
  # TODO: see if there's a more direct/correct way to access this lib
  accent = inputs.ozzie-workstation.lib.hex2rgb config.ozzie.workstation.theme.colours.accent;
in
{
  home.file.".config/hypr/hyprlock-now-playing.sh" = {
    executable = true;
    text = builtins.readFile ./scripts/hyprlock-now-playing.sh;
  };

  programs.hyprlock = {
    enable = true;
    package = with pkgs; hyprlock;

    settings = {
      background = {
        blur_passes = 2;
      };

      general = {
        grace = 5;
        hide_cursor = true;
        no_fade_in = true;
      };

      input-field = {
        hide_input = false;
        outline_thickness = 2;
        size = "350, 60";
      };

      label = [
        {
          color = "rgba(${accent}, 1.0)";
          font_size = 72;
          halign = "center";
          position = "0, 200";
          text = ''cmd[update:1000] date +"%-I:%M%p"'';
          valign = "center";
        }
        {
          color = "rgba(${accent}, 1.0)";
          font_size = 24;
          halign = "center";
          position = "0, 300";
          text = ''cmd[update:1000] date +"%A, %B %d"'';
          valign = "center";
        }
        {
          color = "rgba(${accent}, 1.0)";
          font_size = 24;
          halign = "center";
          position = "0, 50";
          text = ''cmd[update:1000] ~/.config/hypr/hyprlock-now-playing.sh'';
          valign = "bottom";
        }
      ];
    };
  };
}
