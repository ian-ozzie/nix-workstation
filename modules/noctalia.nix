{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.noctalia;
in
{
  options.ozzie.workstation.noctalia = {
    enable = lib.mkEnableOption "opinionated noctalia config";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      adw-gtk3
      qt6Packages.qt6ct
    ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
      systemd.enable = true;
    };
  };
}
