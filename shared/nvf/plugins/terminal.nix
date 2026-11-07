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
        whichKey.register = {
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
          mappings.open = "<leader>tt";

          lazygit = {
            enable = true;
            mappings.open = "<leader>tg";
          };

          setupOpts.on_open = lib.mkIf config.ozzie.workstation.nvf.binds (
            lib.generators.mkLuaInline ''
              function(term)
                if term.hidden then
                  return
                end

                for _, direction in ipairs({ "h", "j", "k", "l" }) do
                  vim.keymap.set("t", "<C-" .. direction .. ">", "<Cmd>wincmd " .. direction .. "<CR>", {
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
