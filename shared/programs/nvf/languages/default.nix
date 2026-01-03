{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages;
in
{
  imports = [
    ./nix.nix
    ./php.nix
    ./rust.nix
    ./ts.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
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

      treesitter = {
        enable = true;
        fold = true;
      };
    };
  };
}
