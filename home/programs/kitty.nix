{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme.colours)
    accent
    alert
    highlight
    lowlight
    ;

  cfg = config.ozzie.workstation.kitty;
in
{
  options.ozzie.workstation.kitty = {
    enable = lib.mkEnableOption "opinionated kitty config";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      package = with pkgs; kitty;

      settings = {
        scrollback_lines = 5000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 4;
        confirm_os_window_close = 0;
        touch_scroll_multiplier = 10.0;
      };

      extraConfig = ''
        tab_bar_style fade
        tab_fade 1
        active_tab_font_style   bold
        inactive_tab_font_style normal

        enable_audio_bell no
        visual_bell_duration 0.5
        visual_bell_color ${highlight}

        tab_bar_edge top
        tab_bar_style powerline
        tab_bar_min_tabs 1
        tab_switch_strategy right
        tab_fade 0.5 0.75 1
        active_tab_font_style bold
        inactive_tab_font_style normal

        active_tab_background ${accent}
        active_tab_foreground ${lowlight}
        bell_border_color ${alert}
        cursor ${accent}
        cursor_text_color ${lowlight}

        copy_on_select clipboard
        mouse_map right press ungrabbed paste_from_selection

        map ctrl+t new_tab
        map ctrl+shift+t set_tab_title
      '';
    };
  };
}
