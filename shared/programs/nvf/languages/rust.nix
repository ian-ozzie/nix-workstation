{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages.rust;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      languages = {
        rust.enable = true;
      };
    };
  };
}
