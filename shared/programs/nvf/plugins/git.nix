{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      extraPlugins."git-messenger-vim" = {
        package = with pkgs; vimPlugins.git-messenger-vim;

        setup = ''
          git_messenger_include_diff = true
        '';
      };

      globals = {
        git_messenger_include_diff = "current";
      };
    };
  };
}
