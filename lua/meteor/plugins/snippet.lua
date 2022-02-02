local M = {}

function M.setup(use)
  use {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<S-tab>'
      vim.cmd [[
        augroup ultisnips_no_auto_expansion
          autocmd!
          autocmd VimEnter * autocmd! UltiSnips_AutoTrigger
        augroup END
        autocmd! UltiSnips_AutoTrigger
      ]]
    end,
    event = 'InsertEnter',
  }
  use {'honza/vim-snippets', event = 'InsertEnter'}
end

return M
