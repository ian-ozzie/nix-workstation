{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.flameshot;
in
{
  options.ozzie.workstation.flameshot = {
    enable = lib.mkEnableOption "opinionated flameshot config";
  };

  config = lib.mkIf cfg.enable {
    services.flameshot = {
      enable = true;
      package = with pkgs; flameshot;

      settings = {
        General = {
          disabledGrimWarning = true;
          disabledTrayIcon = false;
          filenamePattern = "%F_%H-%M";
          saveAsFileExtension = ".png";
          savePath = "/tmp";
          showDesktopNotification = true;
          showHelp = false;
          useGrimAdapter = true;
        };
      };
    };
  };
}
