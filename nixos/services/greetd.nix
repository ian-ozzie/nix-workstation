{
  config,
  lib,
  pkgs,
  ...
}:
let
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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --theme 'border=magenta;text=magenta;prompt=magenta;time=magenta;action=magenta;button=magenta;container=black;input=magenta' --time --cmd ${cfg.command}";
        user = "greeter";
      };
    };
  };
}
