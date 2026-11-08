{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.ozzie.workstation.nvf.languages.enable {
    programs.nvf.settings.vim = {
      diagnostics = {
        presets.stylelint.enable = true;

        nvim-lint = {
          enable = true;
          linters_by_ft.css = [ "stylelint" ];

          linters.stylelint.required_files = [
            "stylelint.config.mjs"
          ];
        };
      };

      languages.css = {
        enable = true;

        format = {
          enable = true;
          type = [ "prettier" ];
        };
      };
    };
  };
}
