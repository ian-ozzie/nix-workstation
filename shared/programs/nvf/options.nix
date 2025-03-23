{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim.options = {
      # Disable modeline, visible with statusline
      showmode = false;

      # Indent settings
      autoindent = true;
      breakindent = true;
      expandtab = true;
      shiftwidth = 2;
      smarttab = true;
      softtabstop = 2;
      tabstop = 2;
      wrap = false;

      # Fold settings
      foldcolumn = "2";
      foldenable = true;
      foldlevelstart = 1;
      foldmethod = "indent";
      foldminlines = 3;

      # Undo settings
      undofile = true;
      undolevels = 1000;
      undoreload = 10000;

      # Keep command history
      history = 10000;

      # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
      ignorecase = true;
      smartcase = true;

      # Keep signcolumn on by default
      signcolumn = "yes";

      # Highlight hidden characters
      listchars = ''tab:󰌒 ,trail:·,nbsp:␣,extends:›'';

      # Decrease update time
      updatetime = 250;

      # Decrease mapped sequence wait time
      timeoutlen = 300;

      # Configure how new splits should be opened
      splitbelow = true;
      splitright = true;

      # Sets how neovim will display certain whitespace characters in the editor.
      list = true;

      # Preview substitutions live, as you type!
      inccommand = "split";

      # Show which line your cursor is on
      cursorline = true;

      # Minimal number of screen lines to keep above and below the cursor.
      scrolloff = 10;

      # When inserting a bracket, briefly jump to its match
      showmatch = true;

      # Tab complete behaviour
      wildmenu = true;
      wildmode = "list:longest,full";

      # Disable mouse support
      mouse = "";
    };
  };
}
