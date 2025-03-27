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
    programs.nvf.settings.vim.extraPlugins."nvim-lastplace" = {
      package = with pkgs; vimPlugins.nvim-lastplace;

      setup = ''
        require("nvim-lastplace").setup({
          lastplace_open_folds = true
        });
      '';
    };
  };
}
