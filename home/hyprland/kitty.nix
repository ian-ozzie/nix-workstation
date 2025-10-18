{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) preset;
  inherit (config.ozzie.workstation.theme.colours)
    accent
    alert
    base
    highlight
    lowlight
    ;

  cfg = config.ozzie.workstation.kitty;
in
{
  options.ozzie.workstation.kitty = {
    binds = lib.mkEnableOption "opinionated kitty binds";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.kitty.enable = false;

    programs.kitty = {
      font = {
        inherit (config.stylix.fonts.monospace) package name;
        size = config.stylix.fonts.sizes.terminal;
      };

      extraConfig = lib.mkIf cfg.binds ''
        clear_all_mouse_actions yes
        mouse_map left click ungrabbed mouse_handle_click selection prompt
        mouse_map left doublepress ungrabbed mouse_selection word
        mouse_map left triplepress ungrabbed mouse_selection line
        mouse_map left press ungrabbed mouse_selection normal

        mouse_map shift+left click grabbed,ungrabbed mouse_handle_click selection prompt
        mouse_map shift+left doublepress ungrabbed,grabbed mouse_selection word
        mouse_map shift+left triplepress ungrabbed,grabbed mouse_selection line

        mouse_map ctrl+left click grabbed,ungrabbed mouse_handle_click link
        mouse_map ctrl+left press grabbed discard_event
        mouse_map ctrl+alt+left press ungrabbed mouse_selection rectangle

        mouse_map right press ungrabbed mouse_selection extend
        mouse_map shift+right press ungrabbed,grabbed mouse_selection extend

        mouse_map middle release ungrabbed paste_from_selection
        mouse_map shift+middle release ungrabbed,grabbed paste_selection
        mouse_map shift+middle press grabbed discard_event
      '';

      keybindings =
        lib.mkIf cfg.binds {
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

      settings = {
        active_border_color = highlight;
        active_tab_background = accent;
        active_tab_font_style = "bold";
        active_tab_foreground = base;
        background = lowlight;
        background_opacity = config.stylix.opacity.terminal;
        bell_border_color = alert;
        bell_on_tab = "󰎉 ";
        clear_all_shortcuts = lib.mkIf cfg.binds true;
        cursor = accent;
        cursor_text_color = lowlight;
        inactive_border_color = accent;
        inactive_tab_background = lowlight;
        inactive_tab_font_style = "normal";
        inactive_tab_foreground = accent;
        inactive_text_alpha = "0.6";
        macos_titlebar_color = lowlight;
        selection_background = accent;
        selection_foreground = lowlight;
        tab_activity_symbol = "";
        tab_bar_background = base;
        tab_bar_edge = "bottom";
        tab_bar_margin_color = accent;
        tab_bar_margin_height = "0.0 2.0";
        tab_bar_style = "powerline";
        tab_title_max_length = "24";
        tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}: {title}{tab.last_focused_progress_percent}";
        touch_scroll_multiplier = 10.0;
        url_color = accent;
        visual_bell_color = highlight;
        visual_bell_duration = "0.5";
        wayland_titlebar_color = lowlight;
        window_border_width = "2px";
        window_padding_width = 4;
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, Q, exec, kitty"
    ];
  };
}
