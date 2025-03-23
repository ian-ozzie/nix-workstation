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
    programs.nvf.settings.vim.extraPlugins."leap-nvim" = {
      package = with pkgs; vimPlugins.leap-nvim;

      setup = ''
        require("leap").create_default_mappings()
      '';
    };
  };
}
