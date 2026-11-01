{
  pkgs,
  ...
}:
{
  catppuccin-mocha = {
    polarity = "dark";

    base16 = {
      accent = "magenta";
      scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };

    colours = {
      accent = "#cba6f7";
      alert = "#d20f39";
      base = "#11111b";
      highlight = "#791aea";
      lowlight = "#1e1e2e";
      text = "#bac2de";
    };
  };

  rose-pine = {
    polarity = "dark";

    base16 = {
      scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
      accent = "blue";
    };

    colours = {
      accent = "#eb6f92";
      alert = "#f6c177";
      base = "#191724";
      highlight = "#8a0f32";
      lowlight = "#26233a";
      text = "#e0def4";
    };
  };

  solarized-dark = {
    polarity = "dark";

    base16 = {
      scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
      accent = "cyan";
    };

    colours = {
      accent = "#2aa198";
      alert = "#dc322f";
      base = "#00191f";
      highlight = "#00438d";
      lowlight = "#002b36";
      text = "#839496";
    };
  };

  solarized-osaka = {
    polarity = "dark";

    base16 = {
      scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
      accent = "cyan";
    };

    colours = {
      accent = "#2aa198";
      alert = "#dc322f";
      base = "#00191f";
      highlight = "#00438d";
      lowlight = "#002b36";
      text = "#839395";
    };
  };

  tokyo-night = {
    polarity = "dark";

    base16 = {
      scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
      accent = "blue";
    };

    colours = {
      accent = "#7aa2f7";
      alert = "#f7768e";
      base = "#15161e";
      highlight = "#0d4fdb";
      lowlight = "#1a1b26";
      text = "#c0caf5";
    };
  };
}
