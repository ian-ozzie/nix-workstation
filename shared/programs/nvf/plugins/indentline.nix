{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.extraPlugins."indentmini.nvim" = {
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "indentmini.nvim";
        version = "v0.0.1";

        src = pkgs.fetchFromGitHub {
          hash = "sha256-RtNPlILvlEyIFfDK8NTq8LPZR5vIl6uBxeE3vftUS6g=";
          owner = "nvimdev";
          repo = "indentmini.nvim";
          rev = "59c2be5387e3a3308bb43f07e7e39fde0628bd4d";
        };
      };

      setup = ''
        require("indentmini").setup({
          exclude = { 'markdown' },
          only_current = false,
        })

        vim.cmd.highlight('IndentLine guifg=#11111b')
        vim.cmd.highlight('IndentLineCurrent guifg=#CBA6F7')
      '';
    };
  };
}
