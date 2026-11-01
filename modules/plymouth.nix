{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie) appearance theme;

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
      font = appearance.fonts.monospace.ttf;
      theme = "spinner";

      package =
        (pkgs.plymouth.override {
          systemd = config.boot.initrd.systemd.package;
        }).overrideAttrs
          (old: {
            postInstall = (old.postInstall or "") + ''
              install -m0644 ${lib.escapeShellArg (toString theme.wallpaper)} \
                "$out/share/plymouth/themes/spinner/background.png"

              sed -i '/^\[two-step\]$/a ScaleBackgroundImage=true' \
                "$out/share/plymouth/themes/spinner/spinner.plymouth"
            '';
          });
    };
  };
}
