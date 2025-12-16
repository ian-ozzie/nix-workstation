{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages.php;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      languages = {
        php.enable = true;
      };
    };
  };
}
