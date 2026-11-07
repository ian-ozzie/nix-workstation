{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages.ts;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      languages = {
        ts.enable = true;
      };
    };
  };
}
