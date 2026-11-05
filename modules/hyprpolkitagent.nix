{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprpolkitagent;
in
{
  options.ozzie.workstation.hyprpolkitagent = {
    enable = lib.mkEnableOption "opinionated hyprpolkitagent config";
  };

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;

    systemd.user.services.hyprpolkitagent = {
      after = [ "graphical-session.target" ];
      description = "Hyprland polkit authentication agent";
      partOf = [ "graphical-session.target" ];
      requisite = [ "graphical-session.target" ];
      unitConfig.ConditionEnvironment = "HYPRLAND_INSTANCE_SIGNATURE";
      wantedBy = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
      };
    };
  };
}
