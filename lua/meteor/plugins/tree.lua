local M = {}

local function nvim_tree_config()
  local icons = require('meteor.icons')

  require('nvim-tree').setup({
    respect_buf_cwd = false,
    diagnostics = {
      enable = true,
      icons = {
        error = icons.error,
        warning = icons.warn,
        hint = icons.hint,
        info = icons.info,
      },
    },
  })
end

function M.setup(use)
  -- Temporary disable nvim-tree due to performance issues.
  use({
    'kyazdani42/nvim-tree.lua',
    config = nvim_tree_config,
    cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
  })
end

return M
