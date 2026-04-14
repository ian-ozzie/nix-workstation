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
    portal = lib.mkEnableOption "kitty as file/settings portal";

    binds = lib.mkEnableOption "configures binds" // {
      default = cfg.enable;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      package = with pkgs; kitty;

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

          "ctrl+left" = "resize_window narrower";
          "ctrl+right" = "resize_window wider";
          "ctrl+up" = "resize_window taller";
          "ctrl+down" = "resize_window shorter";
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
        clear_all_shortcuts = lib.mkDefault cfg.binds;
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
        wheel_scroll_min_lines = 1;
      };
    };

    home.packages = lib.mkIf cfg.portal [
      pkgs.xdg-desktop-portal-gtk
      (pkgs.runCommand "kitty-portal-files" { } ''
        mkdir -p $out/share/dbus-1/services
        cat > $out/share/dbus-1/services/org.freedesktop.impl.portal.desktop.kitty.service << 'EOF'
        [D-BUS Service]
        Name=org.freedesktop.impl.portal.desktop.kitty
        Exec=${config.programs.kitty.package}/bin/kitten desktop-ui run-server
        EOF

        mkdir -p $out/share/xdg-desktop-portal/portals
        cat > $out/share/xdg-desktop-portal/portals/kitty.portal << 'EOF'
        [portal]
        DBusName=org.freedesktop.impl.portal.desktop.kitty
        Interfaces=org.freedesktop.impl.portal.Settings;org.freedesktop.impl.portal.FileChooser;
        EOF
      '')
    ];

    xdg = {
      configFile = {
        "kitty/choose-files.conf" = lib.mkIf (cfg.portal && cfg.binds) {
          text = ''
            map ctrl+h cd ~
            map ctrl+s cd ~/src
            map ctrl+d cd ~/downloads
            map ctrl+f cd ~/files
            map ctrl+p cd ~/pictures

            map ctrl+c quit

            map enter accept
            map shift+enter select
            map alt+i toggle ignorefiles
            map alt+. toggle dotfiles
            map alt+d toggle sort_by_dates
          '';
        };
      };

      portal.config = lib.mkIf cfg.portal {
        hyprland = {
          "org.freedesktop.impl.portal.FileChooser" = [ "kitty" ];
          "org.freedesktop.impl.portal.Settings" = [ "kitty" ];
        };
      };
    };
  };
}
