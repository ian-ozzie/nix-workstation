{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprlauncher;
in
{
  options.ozzie.workstation.hyprlauncher = {
    enable = lib.mkEnableOption "opinionated hyprlauncher config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ hyprlauncher ];

    systemd.user = {
      services.hyprlauncher = {
        Service = {
          ExecStart = "${lib.getExe pkgs.hyprlauncher} -d";
          Restart = "on-failure";
        };

        Unit = {
          Description = "Hyprlauncher daemon";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };
      };
    };
  };
}
