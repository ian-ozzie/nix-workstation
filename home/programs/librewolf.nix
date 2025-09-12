{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.programs.firefox.profiles."${config.home.username}") settings;

  cfg = config.ozzie.workstation.firefox;
  libreSettings = settings // {
    "privacy.clearOnShutdown.cookies" = true;
    "privacy.clearOnShutdown.history" = true;
    "privacy.clearOnShutdown.offlineApps" = true;
    "privacy.clearOnShutdown.sessions" = true;
  };
in
{
  options.ozzie.workstation.librewolf = {
    enable = lib.mkEnableOption "opinionated librewolf config";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.librewolf.enable = false;

    home.activation.removeLibrewolfBackups = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      if [ -f "${config.home.homeDirectory}/files/programs/librewolf/profile/search.json.mozlz4.backup" ]; then
        rm -f ${config.home.homeDirectory}/files/programs/librewolf/profile/search.json.mozlz4.backup
      fi
    '';

    programs.librewolf = {
      enable = true;
      package = with pkgs; librewolf;
      settings = libreSettings;

      profiles."${config.home.username}" = {
        isDefault = true;
        path = "../files/programs/librewolf/profile";

        search = {
          inherit (config.programs.firefox.profiles."${config.home.username}".search) engines;

          force = true;
        };
      };
    };
  };
}
