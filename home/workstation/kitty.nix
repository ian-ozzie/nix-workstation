{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) kitty;

  cfg = config.ozzie.workstation;
in
{
  config = {
    programs.kitty = lib.mkIf kitty.enable {
      settings =
        {
          none = { };

          catppuccin-mocha = {
            foreground = "#bac2de";
            # black
            color0 = "#45475a";
            color8 = "#585b70";
            # red
            color1 = "#f38ba8";
            color9 = "#f38ba8";
            # green
            color2 = "#a6e3a1";
            color10 = "#a6e3a1";
            # yellow
            color3 = "#f9e2af";
            color11 = "#f9e2af";
            # blue
            color4 = "#89b4fa";
            color12 = "#89b4fa";
            # magenta
            color5 = "#cba6f7";
            color13 = "#cba6f7";
            # cyan
            color6 = "#94e2d5";
            color14 = "#94e2d5";
            # white
            color7 = "#bac2de";
            color15 = "#a6adc8";
          };

          rose-pine = {
            foreground = "#e0def4";
            # black
            color0 = "#1f1d2e";
            color8 = "#26233a";
            # red
            color1 = "#eb6f92";
            color9 = "#eb6f92";
            # green
            color2 = "#31748f";
            color10 = "#31748f";
            # yellow
            color3 = "#f6c177";
            color11 = "#f6c177";
            # blue
            color4 = "#9ccfd8";
            color12 = "#9ccfd8";
            # magenta
            color5 = "#c4a7e7";
            color13 = "#c4a7e7";
            # cyan
            color6 = "#ebbcba";
            color14 = "#ebbcba";
            # white
            color7 = "#e0def4";
            color15 = "#e0def4";
          };

          solarized-dark = {
            foreground = "#93a1a1";
            # black
            color0 = "#002b36";
            color8 = "#073642";
            # red
            color1 = "#dc322f";
            color9 = "#f6524f";
            # green
            color2 = "#859900";
            color10 = "#bafb00";
            # yellow
            color3 = "#b58900";
            color11 = "#ffc102";
            # blue
            color4 = "#268bd2";
            color12 = "#48aef5";
            # magenta
            color5 = "#d33682";
            color13 = "#f255a1";
            # cyan
            color6 = "#2aa198";
            color14 = "#27eee0";
            # white
            color7 = "#93a1a1";
            color15 = "#eee8d5";
          };

          solarized-osaka = {
            foreground = "#93a1a1";
            # black
            color0 = "#002b36";
            color8 = "#073642";
            # red
            color1 = "#dc322f";
            color9 = "#f6524f";
            # green
            color2 = "#859900";
            color10 = "#bafb00";
            # yellow
            color3 = "#b58900";
            color11 = "#ffc102";
            # blue
            color4 = "#268bd2";
            color12 = "#48aef5";
            # magenta
            color5 = "#d33682";
            color13 = "#f255a1";
            # cyan
            color6 = "#2aa198";
            color14 = "#27eee0";
            # white
            color7 = "#93a1a1";
            color15 = "#eee8d5";
          };

          tokyo-night = {
            foreground = "#cbccd1";
            # black
            color0 = "#16161e";
            color8 = "#2f3549";
            # red
            color1 = "#f7768e";
            color9 = "#f7768e";
            # green
            color2 = "#41a6b5";
            color10 = "#41a6b5";
            # yellow
            color3 = "#e0af68";
            color11 = "#e0af68";
            # blue
            color4 = "#7aa2f7";
            color12 = "#7aa2f7";
            # magenta
            color5 = "#bb9af7";
            color13 = "#bb9af7";
            # cyan
            color6 = "#7dcfff";
            color14 = "#7dcfff";
            # white
            color7 = "#787c99";
            color15 = "#cbccd1";
          };
        }
        ."${cfg.preset}";
    };
  };
}
