local M = {}

local use_local_repo = false

function M.setup(use)
  use {
    use_local_repo and '~/.config/nvim/my-plugin/vim-color-scheme-meteor' or
        'chmnchiang/vim-color-scheme-meteor',
    as = 'colorscheme',
    requires = 'rktjmp/lush.nvim',
    config = function()
      vim.opt.termguicolors = true
      vim.cmd [[colorscheme meteor-nvim]]
    end,
  }
end

return M
