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
  config = lib.mkIf cfg.enable {
    stylix.targets.kitty.enable = false;

    programs.kitty = {
      font = {
        inherit (config.stylix.fonts.monospace) package name;
        size = config.stylix.fonts.sizes.terminal;
      };

      settings = {
        active_border_color = highlight;
        active_tab_background = accent;
        active_tab_font_style = "bold";
        active_tab_foreground = base;
        background = lowlight;
        background_opacity = config.stylix.opacity.terminal;
        bell_border_color = alert;
        bell_on_tab = "󰎉 ";
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
        tab_powerline_style = "angled";
        tab_title_max_length = "24";
        tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index}  {title}{tab.last_focused_progress_percent}";
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
