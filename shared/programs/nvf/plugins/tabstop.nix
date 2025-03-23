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
    programs.nvf.settings.vim.extraPlugins."vim-sleuth" = {
      package = with pkgs; vimPlugins.vim-sleuth;
    };
  };
}
