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
        confirm_os_window_close = 0;
        copy_on_select = "clipboard";
        cursor_blink_interval = 0.75;
        cursor_stop_blinking_after = 10.0;
        enable_audio_bell = "no";
        enabled_layouts = "splits, tall:bias=60, stack";
        inactive_text_alpha = "0.6";
        mouse_hide_wait = -2.0;
        placement_strategy = "bottom-left";
        scrollback_lines = 5000;
        scrollback_pager = "less --chop-long-lines --raw-control-chars +INPUT_LINE_NUMBER";
        scrollback_pager_history_size = 20;
        touch_scroll_multiplier = 10.0;
        visual_bell_duration = "0.5";
        wheel_scroll_min_lines = 1;
        window_border_width = "2px";
        window_padding_width = 4;

        active_tab_font_style = "bold";
        bell_on_tab = "󰎉 ";
        inactive_tab_font_style = "normal";
        tab_activity_symbol = "";
        tab_bar_edge = "bottom";
        tab_bar_margin_height = "0.0 1.0";
        tab_bar_min_tabs = 1;
        tab_bar_style = "powerline";
        tab_switch_strategy = "right";
        tab_title_max_length = "24";
        tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}: {title}{tab.last_focused_progress_percent}";

        clear_all_shortcuts = "yes";
      };

      keybindings = {
        "ctrl+t" = "new_tab";
        "ctrl+tab" = "next_tab";
        "ctrl+shift+tab" = "previous_tab";
        "ctrl+shift+t" = "set_tab_title";

        "ctrl+shift+l" = "clear_terminal reset active";
        "ctrl+shift+w" = "close_window";

        "ctrl+shift+j" = "scroll_page_down";
        "ctrl+shift+k" = "scroll_page_up";
        "ctrl+shift+h" = "show_scrollback";
        "ctrl+shift+g" = "show_last_command_output";

        "ctrl+shift+v" = "paste_from_clipboard";

        "ctrl+left" = "neighboring_window left";
        "ctrl+right" = "neighboring_window right";
        "ctrl+up" = "neighboring_window up";
        "ctrl+down" = "neighboring_window down";
        "shift+up" = "move_window up";
        "shift+left" = "move_window left";
        "shift+right" = "move_window right";
        "shift+down" = "move_window down";
        "ctrl+shift+up" = "launch --location=hsplit";
        "ctrl+shift+down" = "launch --location=hsplit";
        "ctrl+shift+left" = "launch --location=vsplit";
        "ctrl+shift+right" = "launch --location=vsplit";

        "alt+`" = "move_window_to_top";
        "alt+[" = "prev_window";
        "alt+]" = "next_window";
        "alt+j" = "layout_action rotate";
        "alt+\\" = "next_layout";
      }
      // lib.attrsets.mergeAttrsList (
        map (
          x:
          let
            key = if x == 10 then "0" else toString x;
            tab = toString x;
          in
          {
            "alt+${key}" = "goto_tab ${tab}";
          }
        ) (lib.lists.range 1 10)
      );

      extraConfig = ''
        # Colours here to override stylix theme include
        active_border_color ${highlight}
        active_tab_background ${accent}
        active_tab_foreground ${lowlight}
        bell_border_color ${alert}
        cursor ${accent}
        cursor_text_color ${lowlight}
        inactive_border_color ${accent}
        inactive_tab_background ${lowlight}
        inactive_tab_foreground ${accent}
        selection_background ${accent}
        selection_foreground ${lowlight}
        tab_bar_margin_color ${accent}
        visual_bell_color ${highlight}
      '';
    };
  };
}
