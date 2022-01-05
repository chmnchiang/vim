local M = {}

function M.setup(use)
  use {
    -- 'chmnchiang/vim-color-scheme-meteor',
    '~/.config/nvim/my-plugin/vim-color-scheme-meteor',
    as = 'colorscheme',
    requires = 'rktjmp/lush.nvim',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[colorscheme meteor-nvim]]
    end,
  }
end

return M
