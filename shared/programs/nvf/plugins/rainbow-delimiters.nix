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
    programs.nvf.settings.vim.extraPlugins."rainbow-delimiters-nvim" = {
      package = with pkgs; vimPlugins.rainbow-delimiters-nvim;

      setup = ''
        require('rainbow-delimiters.setup').setup({
        })
      '';
    };
  };
}
