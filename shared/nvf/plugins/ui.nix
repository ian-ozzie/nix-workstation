{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.plugins.ui;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      # Always show to avoid diffs not lining up, and jump as LSP inits
      luaConfigRC.always-show-winbar = ''
        vim.opt.winbar = " "
      '';

      statusline.lualine = {
        enable = true;

        activeSection = {
          a = [
            "{'mode'}"
          ];

          b = [
            "{'branch'}"
            "{'diff'}"
          ];

          c = [
            "{'filename'}"
          ];

          # x = [ "{''}" ]; # Use default nvf lsp + diagnostics

          y = [
            "{'encoding'}"
            "{'fileformat'}"
            "{'filetype'}"
          ];

          z = [
            "{'location'}"
            "{'progress'}"
          ];
        };

        componentSeparator = {
          left = "";
          right = "";
        };

        sectionSeparator = {
          left = "";
          right = "";
        };
      };

      ui = {
        illuminate.enable = true;

        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };

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
