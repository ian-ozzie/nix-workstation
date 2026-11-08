{
  config,
  lib,
  options,
  pkgs,
  ...
}:
let
  accent =
    if options.ozzie.theme.colours.accent.isDefined or false then
      config.ozzie.theme.colours.accent
    else
      null;
  base =
    if options.ozzie.theme.colours.base.isDefined or false then
      config.ozzie.theme.colours.base
    else
      null;

  cfg = config.ozzie.workstation.nvf.plugins.visuals;
in
{
  options.ozzie.workstation.nvf.plugins.visuals = {
    enable = lib.mkEnableOption "opinionated visuals plugins config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      keymaps = lib.mkIf config.ozzie.workstation.nvf.binds [
        {
          key = "]t";
          mode = [ "n" ];
          lua = true;
          action = ''function() require("todo-comments").jump_next() end'';
        }
        {
          key = "[t";
          mode = [ "n" ];
          lua = true;
          action = ''function() require("todo-comments").jump_prev() end'';
        }
      ];

      extraPlugins = {
        "indentmini.nvim" = {
          package = pkgs.vimUtils.buildVimPlugin {
            pname = "indentmini.nvim";
            version = "v0.0.1";

            src = pkgs.fetchFromGitHub {
              hash = "sha256-XcoBNrvFMmEMcgrknDg/HnxRNssom6vLeOKiu1qJKBo=";
              owner = "nvimdev";
              repo = "indentmini.nvim";
              rev = "38572ce5a7a064a5deb89d6d861b7c40fc929ab1";
            };
          };

          setup = ''
            require("indentmini").setup({
              exclude = { 'markdown' },
              only_current = false,
            })

            vim.cmd.highlight('default link IndentLine Whitespace')
            vim.cmd.highlight('default link IndentLineCurrent Special')
          ''
          + lib.optionalString (base != null) ''
            vim.cmd.highlight('IndentLine guifg=${base}')
          ''
          + lib.optionalString (accent != null) ''
            vim.cmd.highlight('IndentLineCurrent guifg=${accent}')
          '';
        };
      };

      notes = {
        todo-comments.enable = true;
      };

      visuals = {
        blink-indent.enable = false;
        cellular-automaton.enable = false;
        cinnamon-nvim.enable = false;
        fidget-nvim.enable = false;
        highlight-undo.enable = true;
        hlargs-nvim.enable = false;
        indent-blankline.enable = false;
        neoscroll-nvim.enable = false;
        nvim-cursorline.enable = false;
        nvim-scrollbar.enable = false;
        nvim-web-devicons.enable = false;
        rainbow-delimiters.enable = true;
        satellite-nvim.enable = false;
        syntax-gaslighting.enable = false;
        tiny-devicons-auto-colors.enable = false;
        twilight-nvim.enable = false;
      };
    };
  };
}
