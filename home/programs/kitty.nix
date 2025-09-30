{
  config,
  lib,
  pkgs,
  ...
}:
let
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
        clipboard_control = "write-clipboard write-primary";
        confirm_os_window_close = 0;
        copy_on_select = "clipboard";
        cursor_blink_interval = 0.75;
        cursor_stop_blinking_after = 10.0;
        enable_audio_bell = false;
        enabled_layouts = "splits, tall:bias=60, stack";
        mouse_hide_wait = -2.0;
        placement_strategy = "bottom-left";
        scrollback_lines = 5000;
        scrollback_pager = "less --chop-long-lines --raw-control-chars +INPUT_LINE_NUMBER";
        scrollback_pager_history_size = 20;
        tab_bar_min_tabs = 1;
        tab_switch_strategy = "right";
        wheel_scroll_min_lines = 1;
      };
    };
  };
}
