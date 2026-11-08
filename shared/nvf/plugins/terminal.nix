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
  options.ozzie.workstation.nvf.plugins.terminal = {
    enable = lib.mkEnableOption "opinionated terminal plugins config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      globals.loaded_netrwPlugin = 1; # Disable netrw for yazi
      telescope.enable = true;

      binds = {
        whichKey.register = lib.mkIf config.ozzie.workstation.nvf.binds {
          "<leader>t" = "Terminal";
        };
      };

      extraPackages = with pkgs; [
        ripgrep
        yazi
      ];

      terminal = {
        toggleterm = {
          enable = true;
          mappings.open = lib.mkIf config.ozzie.workstation.nvf.binds "<leader>tt";

          lazygit = {
            enable = true;
            mappings.open = lib.mkIf config.ozzie.workstation.nvf.binds "<leader>tg";
          };

          setupOpts.on_open = lib.mkIf config.ozzie.workstation.nvf.binds (
            lib.generators.mkLuaInline ''
              function(term)
                if term.hidden then
                  return
                end

                for direction, movement in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
                  vim.keymap.set("t", "<C-" .. direction .. ">", ${
                    if config.programs.nvf.settings.vim.utility.smart-splits.enable then
                      ''function() require("smart-splits")["move_cursor_" .. movement]() end''
                    else
                      ''"<Cmd>wincmd " .. direction .. "<CR>"''
                  }, {
                    buffer = term.bufnr,
                    silent = true,
                  })
                end
              end
            ''
          );
        };
      };

      utility = {
        grug-far-nvim.enable = true;

        yazi-nvim = {
          enable = true;
          setupOpts.open_for_directories = true;

          mappings = lib.mkIf config.ozzie.workstation.nvf.binds {
            openYazi = "<leader>ty";
            openYaziDir = "<leader>tw";
            yaziToggle = "<leader>tr";
          };
        };
      };
    };
  };
}
