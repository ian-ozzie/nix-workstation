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
  options.ozzie.workstation.nvf.plugins.utility = {
    enable = lib.mkEnableOption "opinionated utility plugins config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      fzf-lua.enable = false;
      gestures.gesture-nvim.enable = false;
      navigation.harpoon.enable = false;
      telescope.enable = true;

      binds = {
        whichKey = {
          enable = true;
        };
      };

      extraPlugins = {
        "bigfile-nvim" = {
          package = with pkgs; vimPlugins.bigfile-nvim;

          setup = ''
            require('bigfile').setup({
              filesize = 4, -- In MiB

              features = {
                "indent_blankline",
                "illuminate",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
              },
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
        -- https://github.com/neovim/neovim/blob/v0.11.5/runtime/lua/editorconfig.lua#L157-L160
        -- Remove trailing whitespace on save, hook so it doesn't require editorconfig within projects
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*",
          callback = function()
            local view = vim.fn.winsaveview()
            vim.api.nvim_command('silent! undojoin')
            vim.api.nvim_command('silent keepjumps keeppatterns %s/\\s\\+$//e')
            vim.fn.winrestview(view)
          end,
        })
      '';

      utility = {
        auto-indent-nvim.enable = false;
        ccc.enable = true;
        crazy-coverage.enable = false;
        csvview.enable = false;
        diffview-nvim.enable = false;
        direnv.enable = true;
        guess-indent-nvim.enable = false;
        icon-picker.enable = false;
        leetcode-nvim.enable = false;
        mkdir.enable = true;
        multicursors.enable = false;
        new-file-template.enable = false;
        nix-develop.enable = true;
        oil-nvim.enable = false;
        outline.aerial-nvim.enable = false;
        qmk-nvim.enable = false;
        sleuth.enable = true;
        smart-paste-nvim.enable = false;
        snacks-nvim.enable = false;
        surround.enable = true;
        undotree.enable = false;
        vim-wakatime.enable = false;
        yanky-nvim.enable = false;

        images = {
          image-nvim.enable = false;
          img-clip.enable = false;
        };

        motion = {
          flash-nvim.enable = false;
          hop.enable = false;
          precognition.enable = false;

          leap = {
            enable = true;

            mappings = {
              leapBackwardTo = "S";
              leapForwardTo = "s";
            };
          };
        };

        nvim-biscuits = {
          enable = true;
          setupOpts.cursor_line_only = true;
        };

        preview = {
          glow.enable = false;
          markdownPreview.enable = false;
        };

        smart-splits = {
          enable = true;

          keymaps = {
            move_cursor_down = null;
            move_cursor_left = null;
            move_cursor_previous = "<C-`>";
            move_cursor_right = null;
            move_cursor_up = null;
          };
        };
      };
    };
  };
}
