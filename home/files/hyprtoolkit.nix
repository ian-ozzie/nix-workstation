{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation.theme) colours;

  accent = "0xff" + lib.strings.removePrefix "#" colours.accent;
  base = "0xff" + lib.strings.removePrefix "#" colours.base;
  highlight = "0xff" + lib.strings.removePrefix "#" colours.highlight;

  cfg = config.ozzie.workstation.hyprtoolkit;
in
{
  options.ozzie.workstation.hyprtoolkit = {
    enable = lib.mkEnableOption "opinionated hyprtoolkit config";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "hypr/hyprtoolkit.conf".text = ''
        background = ${base}
        base = ${base}
        alternate_base = ${base}
        text = ${accent}
        bright_text = ${highlight}
        accent = ${accent}
        accent_secondary = ${highlight}

        h1_size = 24
        h2_size = 20
        h3_size = 16
        font_size = 14
        small_font_size = 12

        rounding_large = 1
        rounding_small = 1
      '';
    };
  };
}
