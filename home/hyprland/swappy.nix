{
  config,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme.colours) accent;
in
{
  home = {
    file.".config/swappy/config".text = ''
      [Default]
      auto_save=false
      custom_color=${accent}
      early_exit=true
      fill_shape=false
      line_size=2
      paint_mode=brush
      save_dir=$HOME/pictures
      save_filename_format=screenshot_%Y-%m-%d_%H-%M-%S.png
      show_panel=false
      text_font=sans-serif
      text_size=18
    '';

    packages = with pkgs; [
      swappy
    ];
  };
}
