{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation) hyprland;

  cfg = config.ozzie.workstation.xdg;
  kittyPortalEnabled = cfg.fileChooser == "kitty" || cfg.settingsProvider == "kitty";

  kittyPortal = pkgs.runCommand "kitty-portal" { } ''
    mkdir -p "$out/share/dbus-1/services" "$out/share/xdg-desktop-portal/portals"

    cat > "$out/share/dbus-1/services/org.freedesktop.impl.portal.desktop.kitty.service" << EOF
    [D-BUS Service]
    Name=org.freedesktop.impl.portal.desktop.kitty
    Exec=${pkgs.kitty}/bin/kitten desktop-ui run-server
    EOF

    cat > "$out/share/xdg-desktop-portal/portals/kitty.portal" << EOF
    [portal]
    DBusName=org.freedesktop.impl.portal.desktop.kitty
    Interfaces=org.freedesktop.impl.portal.FileChooser;org.freedesktop.impl.portal.Settings;
    EOF
  '';

in
{
  options.ozzie.workstation.xdg = {
    debug = lib.mkEnableOption "when troubleshooting";
    enable = lib.mkEnableOption "opinionated xdg config";

    fileChooser = lib.mkOption {
      default = "gtk";

      type = lib.types.nullOr (
        lib.types.enum [
          "gtk"
          "kitty"
          "none"
        ]
      );
    };

    keyring = lib.mkOption {
      default = "gnome-keyring";

      type = lib.types.nullOr (
        lib.types.enum [
          "gnome-keyring"
          "none"
        ]
      );
    };

    settingsProvider = lib.mkOption {
      default = "gtk";

      type = lib.types.nullOr (
        lib.types.enum [
          "gtk"
          "kitty"
          "none"
        ]
      );
    };
  };

  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = lib.mkIf (cfg.keyring == "gnome-keyring") true;

    programs.dconf = lib.mkIf (cfg.settingsProvider == "gtk") {
      enable = true;

      profiles.user.databases = [
        {
          settings."org/gnome/desktop/interface".color-scheme = "prefer-${config.ozzie.appearance.polarity}";
        }
      ];
    };

    environment = {
      systemPackages = lib.optionals kittyPortalEnabled [ pkgs.kitty ];

      sessionVariables = lib.mkIf (cfg.fileChooser == "kitty") {
        GTK_USE_PORTAL = "1";
        QT_QPA_PLATFORMTHEME = lib.mkDefault "xdgdesktopportal";
      };
    };

    systemd.user.services.portal-test = lib.mkIf cfg.debug {
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig.ExecStart = lib.getExe pkgs.ashpd-demo;
      wantedBy = [ "graphical-session.target" ];
    };

    xdg.portal = {
      enable = true;

      config =
        let
          portalConfig = {
            "org.freedesktop.impl.portal.FileChooser" = lib.mkIf (cfg.fileChooser != null) cfg.fileChooser;
            "org.freedesktop.impl.portal.Secret" = lib.mkIf (cfg.keyring != null) cfg.keyring;
            default = [ "gtk" ];

            "org.freedesktop.impl.portal.Settings" = lib.mkIf (
              cfg.settingsProvider != null
            ) cfg.settingsProvider;
          };
        in
        {
          common = portalConfig;

          hyprland = lib.mkIf hyprland.enable (
            portalConfig
            // {
              default = [
                "hyprland"
                "gtk"
              ];
            }
          );
        };

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ]
      ++ lib.optional kittyPortalEnabled kittyPortal;
    };
  };
}
