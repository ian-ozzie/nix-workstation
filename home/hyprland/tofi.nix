{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme.colours)
    accent
    lowlight
    ;

  cfg = config.ozzie.workstation.tofi;
in
{
  config = lib.mkIf cfg.enable {
    programs.tofi.settings = {
      border-width = lib.mkForce 0;
      drun-launch = true;
      font = lib.mkForce "${pkgs.dejavu_fonts}/share/fonts/truetype/DejaVuSansMono.ttf";
      hide-cursor = true;
      history = true;
      multi-instance = false;
      num-results = 9;
      outline-color = lib.mkForce accent;
      prompt-color = lib.mkForce accent;
      prompt-padding = 10;
      prompt-text = "❯";
      result-spacing = 8;
      selection-background = lib.mkForce lowlight;
      selection-background-padding = 5;
      selection-color = lib.mkForce accent;
      terminal = "kitty";
      text-cursor = true;
    };
  };
}
