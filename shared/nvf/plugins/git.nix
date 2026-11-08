{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.plugins.git;
in
{
  options.ozzie.workstation.nvf.plugins.git = {
    enable = lib.mkEnableOption "opinionated git plugins config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      binds = {
        whichKey.register = lib.mkIf config.ozzie.workstation.nvf.binds {
          "<leader>c" = "Git-Conflict";
          "<leader>g" = "Git";
          "<leader>gt" = "Toggle";
          "<leader>h" = lib.mkForce null;
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

          mappings = lib.mkIf config.ozzie.workstation.nvf.binds {
            both = "<leader>cb";
            nextConflict = "]x";
            none = "<leader>c0";
            ours = "<leader>co";
            prevConflict = "[x";
            theirs = "<leader>ct";
          };
        };

        gitsigns = {
          codeActions.enable = false;
          enable = true;
          setupOpts.current_line_blame = true;

          mappings = lib.mkIf config.ozzie.workstation.nvf.binds {
            blameLine = "<leader>gb";
            diffProject = "<leader>gD";
            diffThis = "<leader>gd";
            nextHunk = null;
            previewHunk = "<leader>gP";
            previousHunk = null;
            resetBuffer = "<leader>gR";
            resetHunk = "<leader>gr";
            stageBuffer = "<leader>gS";
            stageHunk = "<leader>gs";
            toggleBlame = "<leader>gtB";
            toggleDeleted = null;
            undoStageHunk = null;
          };
        };
      };

      maps = lib.mkIf config.ozzie.workstation.nvf.binds {
        normal = {
          "[h" = {
            action = "<cmd>Gitsigns nav_hunk prev<CR>";
          };
          "]h" = {
            action = "<cmd>Gitsigns nav_hunk next<CR>";
          };
          "<leader>gc" = {
            action = "<cmd>Gitsigns setqflist all<CR>";
          };
          "<leader>gtb" = {
            action = "<cmd>Gitsigns blame<CR>";
          };
          "<leader>gtd" = {
            action = "<cmd>Gitsigns preview_hunk_inline<CR>";
          };
        };
      };
    };
  };
}
