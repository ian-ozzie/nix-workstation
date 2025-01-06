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
    environment.systemPackages = with pkgs; [
      greetd.tuigreet
    ];

    services.greetd = {
      enable = true;
      vt = 2;

      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --theme 'border=${accent};text=${accent};prompt=${accent};time=${accent};action=${accent};button=${accent};container=black;input=${accent}' --time --cmd ${cfg.command}";
        user = "greeter";
      };
    };
  };
}
