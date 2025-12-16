{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf;
in
{
  imports = [
    ./bigfile.nix
    ./git.nix
    ./indentline.nix
    ./lastplace.nix
    ./motion.nix
    ./rainbow-delimiters.nix
    ./spaceless.nix
    ./statusline.nix
    ./surround.nix
    ./tabstop.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      binds = {
        whichKey.enable = true;
      };

      comments = {
        comment-nvim.enable = true;
      };

      git = {
        enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
        gitsigns.enable = true;
      };

      languages = {
        bash.enable = true;
        enableExtraDiagnostics = true;
        enableFormat = false;
        enableTreesitter = true;
        markdown.enable = true;
      };

      lsp = {
        enable = true;
        formatOnSave = false;
        inlayHints.enable = true;
        lightbulb.enable = false;
        lspSignature.enable = true;
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

      notes = {
        todo-comments.enable = true;
      };

      terminal = {
        toggleterm = {
          enable = true;
          mappings.open = "<leader>tt";

          lazygit = {
            enable = true;
            mappings.open = "<leader>tg";
          };
        };
      };

      ui = {
        illuminate.enable = true;

        smartcolumn = {
          enable = true;

          setupOpts.colorcolumn = [
            "80"
            "120"
          ];
        };
      };

      utility = {
        ccc.enable = true;
        yanky-nvim.enable = true;

        images.image-nvim = {
          enable = true;
          setupOpts.backend = "kitty";
        };

        nvim-biscuits = {
          enable = true;
          setupOpts.cursor_line_only = true;
        };
      };

      visuals = {
        highlight-undo.enable = true;
      };
    };
  };
}
