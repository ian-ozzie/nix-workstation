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
    programs.nvf.settings.vim.extraPlugins."bigfile-nvim" = {
      package = with pkgs; vimPlugins.bigfile-nvim;

      setup = ''
        require('bigfile').setup({
          filesize = 5, -- size of the file in MiB
        })
      '';
    };
  };
}
