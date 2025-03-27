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
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableLSP = true;
        enableTreesitter = true;
        nix.enable = true;
        php.enable = true;
        tailwind.enable = true;
        ts.enable = true;
      };

      lsp = {
        enable = true;
        formatOnSave = false;
        lightbulb.enable = false;
        lspSignature.enable = true;
        lspkind.enable = false;
        lsplines.enable = false;
        lspsaga.enable = false;
        nvim-docs-view.enable = false;
        otter-nvim.enable = false;
        trouble.enable = true;
      };

      notes = {
        todo-comments.enable = true;
      };

      ui = {
        smartcolumn = {
          enable = true;

          setupOpts.colorcolumn = [
            "80"
            "120"
          ];
        };
      };
    };
  };
}
