{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.plugins.git;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      binds = {
        whichKey.register = {
          "<leader>h" = lib.mkForce null;
          "<leader>g" = "Git";
          "<leader>gt" = "Toggle";
          "<leader>c" = "Git-Conflict";
        };
      };

      extraPlugins = {
        "git-messenger-vim" = {
          package = with pkgs; vimPlugins.git-messenger-vim;
        };
      };

      git = {
        enable = false;
        gitlinker-nvim.enable = false;
        hunk-nvim.enable = false;
        neogit.enable = false;
        vim-fugitive.enable = true;

        git-conflict = {
          enable = true;

          mappings = {
            nextConflict = "<leader>c[";
            prevConflict = "<leader>c]";
            ours = "<leader>co";
            theirs = "<leader>ct";
            both = "<leader>cb";
            none = "<leader>c0";
          };
        };

        gitsigns = {
          codeActions.enable = false;
          enable = true;
          setupOpts.current_line_blame = true;

          mappings = {
            blameLine = null;
            diffProject = "<leader>gD";
            diffThis = "<leader>gd";
            nextHunk = "<leader>g]";
            previewHunk = "<leader>gP";
            previousHunk = "<leader>g[";
            resetBuffer = "<leader>gR";
            resetHunk = "<leader>gr";
            stageBuffer = "<leader>gS";
            stageHunk = "<leader>gs";
            toggleBlame = "<leader>gtb";
            toggleDeleted = "<leader>gtd";
            undoStageHunk = "<leader>gu";
          };
        };
      };

      globals = {
        git_messenger_include_diff = "current";
        git_messenger_no_default_mappings = true;
      };

      maps = {
        normal = {
          "<leader>gb" = {
            action = ":GitMessenger<CR>";
            desc = "Blame [Git-Messenger]";
          };
        };
      };
    };
  };
}
