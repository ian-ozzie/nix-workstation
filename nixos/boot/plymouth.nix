{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation) theme;

  cfg = config.ozzie.workstation.plymouth;
in
{
  options.ozzie.workstation.plymouth = {
    enable = lib.mkEnableOption "opinionated plymouth config";
  };

  config = lib.mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      extraConfig = lib.mkDefault "DeviceScale=1";
      font = theme.nerd-font.ttf;

      package =
        with pkgs;
        plymouth.override {
          systemd = config.boot.initrd.systemd.package;
        };
    };

    stylix.targets.plymouth = {
      enable = true;
      logo = theme.wallpaper.png;
      logoAnimated = false;
    };
  };
}
