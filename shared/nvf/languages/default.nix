{
  config,
  lib,
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
  };

  imports = [
    # ./nix.nix
    # ./php.nix
    # ./rust.nix
    # ./ts.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      autocomplete.blink-cmp = {
        enable = true;

        setupOpts = {
          cmdline.enabled = false;
          completion.list.selection.preselect = false;
          signature.enabled = true;
        };
      };

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
