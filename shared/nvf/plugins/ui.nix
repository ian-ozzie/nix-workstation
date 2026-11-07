{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.plugins.ui;
in
{
  options.ozzie.workstation.nvf.plugins.ui = {
    enable = lib.mkEnableOption "opinionated ui plugins config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      keymaps = [
        {
          key = "<leader>tn";
          mode = [ "n" ];
          action = "<cmd>Navbuddy<CR>";
        }
      ];

      # Always show to avoid diffs not lining up, and jump as LSP inits
      luaConfigRC.always-show-winbar = ''
        vim.opt.winbar = " "
      '';

      statusline.lualine = {
        enable = true;

        integrations.breadcrumbs = {
          location = "winbar";
          navbuddy.enable = true;
        };

        setupOpts = {
          inactive_sections.lualine_c = [
            {
              "@1" = "filename";
              path = 1;
            }
          ];

          options = {
            component_separators = {
              left = "";
              right = "";
            };

            section_separators = {
              left = "";
              right = "";
            };
          };

          sections = {
            lualine_a = [
              "mode"
            ];

            lualine_b = [
              "branch"
              "diff"
            ];

            lualine_c = [
              {
                "@1" = "filename";
                path = 1;
              }
            ];

            lualine_y = [
              {
                "@1" = "searchcount";
                maxcount = 999;
                timeout = 100;
              }

              "encoding"
              "fileformat"
              "filetype"
            ];

            lualine_z = [
              "location"
              "progress"
            ];
          };
        };
      };

      ui = {
        borders.enable = false;
        colorful-menu-nvim.enable = false;
        colorizer.enable = false;
        dropbar-nvim.enable = false;
        fastaction.enable = false;
        illuminate.enable = true;
        modes-nvim.enable = false;
        noice.enable = false;
        nvim-highlight-colors.enable = false;
        nvim-ufo.enable = false;
        ui2.enable = false;
        zen-nvim.enable = false;

        smartcolumn = {
          enable = true;

          setupOpts = {
            scope = "window";

            colorcolumn = [
              "80"
              "120"
            ];
          };
        };
      };
    };
  };
}
