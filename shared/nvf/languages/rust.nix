{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages.rust;
in
{
  options.ozzie.workstation.nvf.languages.rust = {
    enable = lib.mkEnableOption "opinionated rust config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    ozzie.workstation.nvf.languages.neotestAdapters = [
      ''require("rustaceanvim.neotest")''
    ];

    programs.nvf.settings.vim = {
      languages = {
        rust = {
          enable = true;
          lsp.enable = false;

          extensions.rustaceanvim = {
            enable = true;

            setupOpts = {
              dap.adapter = false;

              server = lib.mkOptionDefault {
                default_settings."rust-analyzer".check.command = "clippy";
              };
            };
          };
        };
      };
    };
  };
}
