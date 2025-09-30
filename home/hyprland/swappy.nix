{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation.theme.colours) accent;

  cfg = config.ozzie.workstation.swappy;
in
{
  config = lib.mkIf cfg.enable {
    ozzie.workstation.hyprshot.enable = true;

    programs.swappy.settings.Default = {
      auto_save = false;
      custom_color = accent;
      early_exit = true;
      fill_shape = false;
      line_size = 2;
      paint_mode = "brush";
      save_dir = "$XDG_PICTURES_DIR";
      save_filename_format = "screenshot-%Y-%m-%d_%H-%M-%S.png";
      show_panel = false;
      text_font = "sans-serif";
      text_size = 18;
    };

    wayland.windowManager.hyprland.settings.bind = [
      "ALT SHIFT, 2, exec, hyprshot -z -m output -r stdout | swappy -f -"
      "ALT SHIFT, 3, exec, hyprshot -z -m window -r stdout | swappy -f -"
      "ALT SHIFT, 4, exec, hyprshot -z -m region -r stdout | swappy -f -"
    ];
  };
}
