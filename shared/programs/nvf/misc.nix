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
    programs.nvf.settings.vim.luaConfigRC.misc = ''
      -- Dynamic true/relative line numbers
      vim.opt.number = true
      vim.opt.relativenumber = true

      vim.api.nvim_create_autocmd('InsertEnter', { command = [[set norelativenumber]] })
      vim.api.nvim_create_autocmd('InsertLeave', { command = [[set relativenumber]] })

      vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
        callback = function()
          vim.diagnostic.open_float(nil, { focusable = false })
        end,
      })
    '';
  };
}
