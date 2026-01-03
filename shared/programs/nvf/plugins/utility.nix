{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.plugins.utility;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      binds = {
        whichKey = {
          enable = true;
        };
      };

      extraPlugins = {
        "bigfile-nvim" = {
          package = with pkgs; vimPlugins.bigfile-nvim;

          # Filesize is in MiB
          setup = ''
            require('bigfile').setup({
              filesize = 4,
            })
          '';
        };

        "nvim-lastplace" = {
          package = with pkgs; vimPlugins.nvim-lastplace;

          setup = ''
            require("nvim-lastplace").setup({
              lastplace_open_folds = true
            });
          '';
        };
      };

      luaConfigRC.no-trailing-whitespace = ''
        -- https://old.reddit.com/r/neovim/comments/1pfs3kf/remove_trailing_space_on_save/
        -- Remove trailing whitespace on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*",
          callback = function()
            local bufnr = vim.api.nvim_get_current_buf()
            local pos = vim.api.nvim_win_get_cursor(0)
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local modified = false

            for i, line in ipairs(lines) do
              local trimmed = line:gsub("%s+$", "")
              if trimmed ~= line then
                lines[i] = trimmed
                modified = true
              end
            end

            if modified then
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            end

            vim.api.nvim_win_set_cursor(0, pos)
          end,
        })
      '';

      utility = {
        ccc.enable = true;
        diffview-nvim.enable = true;
        direnv.enable = true;
        mkdir.enable = true;
        nix-develop.enable = true;
        sleuth.enable = true;
        snacks-nvim.enable = false;
        surround.enable = true;
        yanky-nvim.enable = false;

        motion.leap = {
          enable = true;

          mappings = {
            leapBackwardTo = "S";
            leapForwardTo = "s";
          };
        };

        nvim-biscuits = {
          enable = true;
          setupOpts.cursor_line_only = true;
        };

        smart-splits = {
          enable = true;
          keymaps.move_cursor_previous = "<C-`>";
        };
      };
    };
  };
}
