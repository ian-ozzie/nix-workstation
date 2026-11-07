{
  programs.nvf.settings.vim.luaConfigRC.misc = ''
    local group = vim.api.nvim_create_augroup('ozzie_nvf_misc', { clear = true })

    -- Dynamic true/relative line numbers
    vim.opt.number = true
    vim.opt.relativenumber = true

    vim.api.nvim_create_autocmd('ModeChanged', {
      group = group,
      pattern = { '*:[iR]*', '[iR]*:*' },
      callback = function()
        vim.wo.relativenumber = not vim.v.event.new_mode:match('^[iR]')
      end,
    })

    vim.api.nvim_create_autocmd('CursorHold', {
      group = group,
      callback = function()
        vim.diagnostic.open_float({ focusable = false })
      end,
    })
  '';
}
