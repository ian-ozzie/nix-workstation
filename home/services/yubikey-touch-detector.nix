{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.yubikey-touch-detector;
in
{
  options.ozzie.workstation.yubikey-touch-detector = {
    enable = lib.mkEnableOption "opinionated yubikey-touch-detector config";
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services.yubikey-touch-detector = {
        Service.ExecStart = lib.getExe pkgs.yubikey-touch-detector;
        Unit.Description = "Yubikey Touch Detector daemon";
      };

      sockets.yubikey-touch-detector = {
        Install.WantedBy = [ "sockets.target" ];
        Unit.Description = "Yubikey Touch Detector daemon";

        Socket = {
          Accept = false;
          ListenStream = "%t/yubikey-touch-detector.socket";
          SocketMode = "0600";
        };
      };
    };
  };
}
