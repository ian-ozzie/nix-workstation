{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) preset;

  cfg = config.ozzie.workstation.nvf;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.theme = {
      enable = true;
      transparent = lib.mkDefault false;
    }
    // {
      none = { };

      catppuccin-mocha = {
        name = "catppuccin";
        style = "mocha";
      };

      rose-pine = {
        name = "rose-pine";
        style = "main";
      };

      solarized-dark = {
        name = "solarized";
        style = "dark";
      };

      solarized-osaka = {
        name = "solarized-osaka";
      };

      tokyo-night = {
        name = "tokyonight";
        style = "night";
      };
    }
    ."${preset}";

    stylix.targets.nvf = lib.mkIf (preset != "none") {
      enable = false;
    };
  };
}
