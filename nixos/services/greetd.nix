{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme.base16) accent;

  cfg = config.ozzie.workstation.greetd;
in
{
  options.ozzie.workstation.greetd = {
    enable = lib.mkEnableOption "opinionated greetd config";

    command = lib.mkOption {
      description = "command to run through tuigreet";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;

      settings.default_session = {
        user = "greeter";

        command = builtins.concatStringsSep " " [
          "${lib.getExe pkgs.tuigreet}"
          "--remember"
          "--remember-session"
          "--time"
          "--theme 'border=${accent};text=${accent};prompt=${accent};time=${accent};action=${accent};button=${accent};container=black;input=${accent}'"
          "--sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
          "--cmd ${cfg.command}"
        ];
      };
    };
  };
}
