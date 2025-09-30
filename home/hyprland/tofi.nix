{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation.theme) colours;
  inherit (colours)
    accent
    highlight
    lowlight
    ;

  cfg = config.ozzie.workstation.tofi;
in
{
  config = lib.mkIf cfg.enable {
    stylix.targets.tofi.enable = false;

    programs.tofi.settings = {
      background-color = lowlight;
      border-color = highlight;
      border-width = 0;
      default-result-background = lowlight;
      drun-launch = true;
      font = lib.mkForce config.ozzie.workstation.theme.nerd-font.ttf;
      font-size = config.stylix.fonts.sizes.popups;
      hide-cursor = true;
      history = true;
      input-background = lowlight;
      multi-instance = false;
      num-results = 9;
      outline-color = accent;
      outline-width = 2;
      placeholder-color = accent;
      prompt-background = lowlight;
      prompt-color = accent;
      prompt-padding = 18;
      prompt-text = "❯";
      result-spacing = 8;
      selection-background = highlight;
      selection-background-padding = 5;
      selection-color = accent;
      terminal = "kitty";
      text-color = accent;
      text-cursor = true;
    };

    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, R, exec, tofi-drun --width 640 --height 360"
    ];
  };
}
