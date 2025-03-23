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
    programs.nvf.settings.vim.extraPlugins."nvim-surround" = {
      package = with pkgs; vimPlugins.nvim-surround;

      setup = ''
        require("nvim-surround").setup()
      '';
    };
  };
}
