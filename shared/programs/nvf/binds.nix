{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf;
in
{
  options.ozzie.workstation.nvf = {
    binds = lib.mkEnableOption "opinionated nvf binds" // {
      default = cfg.enable;
    };
  };

  config = lib.mkIf cfg.binds {
    programs.nvf.settings.vim.keymaps = [
      {
        action = "<cmd>nohlsearch<CR>";
        desc = "Clear highlight from search";
        key = "<Esc>";
        mode = [ "n" ];
      }
      {
        action = "<C-\\><C-n>";
        desc = "Exit terminal mode";
        key = "<Esc><Esc>";
        mode = [ "t" ];
      }
      {
        action = "<C-w><C-h>";
        desc = "Move focus to the left window";
        key = "<C-h>";
        mode = [ "n" ];
      }
      {
        action = "<C-w><C-j>";
        desc = "Move focus to the lower window";
        key = "<C-j>";
        mode = [ "n" ];
      }
      {
        action = "<C-w><C-k>";
        desc = "Move focus to the upper window";
        key = "<C-k>";
        mode = [ "n" ];
      }
      {
        action = "<C-w><C-l>";
        desc = "Move focus to the right window";
        key = "<C-l>";
        mode = [ "n" ];
      }
      {
        action = "<Left>";
        desc = "Move left in insert mode";
        key = "<C-h>";
        mode = [ "i" ];
      }
      {
        action = "<Down>";
        desc = "Move down in insert mode";
        key = "<C-j>";
        mode = [ "i" ];
      }
      {
        action = "<Up>";
        desc = "Move up in insert mode";
        key = "<C-k>";
        mode = [ "i" ];
      }
      {
        action = "<Right>";
        desc = "Move right in insert mode";
        key = "<C-l>";
        mode = [ "i" ];
      }
      {
        action = ">gv";
        desc = "Increase indent and keep selection";
        key = ">";
        mode = [ "v" ];
      }
      {
        action = "<gv";
        desc = "Increase indent and keep selection";
        key = "<";
        mode = [ "v" ];
      }
    ];
  };
}
