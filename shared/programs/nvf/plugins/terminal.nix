{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.plugins.terminal;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      binds = {
        whichKey.register = {
          "<leader>t" = "Terminal";
        };
      };

      terminal = {
        toggleterm = {
          enable = true;
          mappings.open = "<leader>tt";

          lazygit = {
            enable = true;
            mappings.open = "<leader>tg";
            package = with pkgs; lazygit;
          };
        };
      };

      utility = {
        yazi-nvim = {
          enable = true;

          mappings = {
            openYazi = "<leader>ty";
            openYaziDir = "<leader>tw";
            yaziToggle = "<leader>tr";
          };
        };
      };
    };
  };
}
