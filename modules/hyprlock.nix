{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprlock;
in
{
  options.ozzie.workstation.hyprlock = {
    enable = lib.mkEnableOption "opinionated hyprlock config";
    enableHypridle = lib.mkEnableOption "separate hypridle flag as hyprlock enables this";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock.enable = true;
    services.hypridle.enable = lib.mkForce cfg.enableHypridle;
  };
}
