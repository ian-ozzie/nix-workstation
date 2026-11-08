{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages;
in
{
  options.ozzie.workstation.nvf.languages = {
    enable = lib.mkEnableOption "opinionated languages config" // {
      default = true;
    };

    neotestAdapters = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      internal = true;
    };
  };

  imports = [
    ./css.nix
    ./nix.nix
    ./php.nix
    ./rust.nix
    ./typescript.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      binds.whichKey.register."<leader>lt" = "Tests";
      formatter.conform-nvim.enable = true;

      autocomplete.blink-cmp = {
        enable = true;

        setupOpts = {
          cmdline.enabled = false;
          completion.list.selection.preselect = false;
          signature.enabled = true;
        };
      };

      extraPlugins.neotest = {
        package = pkgs.vimPlugins.neotest;
        setup = ''
          require("neotest").setup({
            adapters = {
              ${lib.concatStringsSep ",\n" cfg.neotestAdapters}
            },
          })
        '';
      };

      keymaps = [
        {
          action = "<cmd>lua require('conform').format({ async = true })<CR>";
          desc = "Format file";
          key = "<leader>lf";
          mode = [ "n" ];
        }
        {
          action = "<cmd>lua require('neotest').run.run({ suite = true })<CR>";
          desc = "Run all tests";
          key = "<leader>lta";
          mode = "n";
        }
        {
          action = "<cmd>lua require('neotest').run.run()<CR>";
          desc = "Run nearest test";
          key = "<leader>ltn";
          mode = "n";
        }
        {
          action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%:p'))<CR>";
          desc = "Run test file";
          key = "<leader>ltf";
          mode = "n";
        }
        {
          action = "<cmd>lua require('neotest').run.run_last()<CR>";
          desc = "Rerun last test";
          key = "<leader>ltl";
          mode = "n";
        }
        {
          action = "<cmd>lua require('neotest').summary.toggle()<CR>";
          desc = "Toggle test summary";
          key = "<leader>lts";
          mode = "n";
        }
        {
          action = "<cmd>lua require('neotest').output.open({ enter = true })<CR>";
          desc = "Open test output";
          key = "<leader>lto";
          mode = "n";
        }
      ];

      languages = {
        enableExtraDiagnostics = true;
        enableFormat = false;
        enableTreesitter = true;

        bash = {
          enable = true;

          format = {
            enable = true;
            type = [ "shfmt" ];
          };
        };

        markdown = {
          enable = true;

          format = {
            enable = true;
            type = [ "prettier" ];
          };
        };
      };

      lsp = {
        enable = true;
        formatOnSave = false;
        inlayHints.enable = true;
        lightbulb.enable = false;
        lspSignature.enable = false;
        lspkind.enable = false;
        lspsaga.enable = false;
        nvim-docs-view.enable = false;
        otter-nvim.enable = false;

        mappings = {
          format = null;
          toggleFormatOnSave = null;
        };

        trouble = {
          enable = true;

          setupOpts = {
            auto_close = true;
          };
        };
      };

      treesitter = {
        enable = true;
        fold = true;
      };
    };
  };
}
