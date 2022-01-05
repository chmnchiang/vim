local M = {}

local function nvim_tree_config()
  local icons = require('meteor.icons')
  require('meteor.utils').noresimap('n', '<leader>t', '<Cmd>NvimTreeToggle<CR>')
  vim.g.nvim_tree_respect_buf_cwd = 0

  require('nvim-tree').setup {
    diagnostics = {
      enable = true,
      icons = {
        error = icons.error,
        warning = icons.warn,
        hint = icons.hint,
        info = icons.info,
      },
    },
  }
end

function M.setup(use)
  -- Temporary disable nvim-tree due to performance issues.
  -- use {'kyazdani42/nvim-tree.lua', config = nvim_tree_config}
end

return M
