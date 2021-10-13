local M = {}

local function nvim_tree_config()
  require'meteor.utils'.noresimap(
    'n', '<leader>t', '<cmd>:NvimTreeToggle<CR>')
  vim.g.nvim_tree_respect_buf_cwd = 0

  require'nvim-tree'.setup {
    diagnostics = {
      enable = true,
      icons = {
        hint = '',
        info = ' ',
        warning = ' ',
        error = ' ',
      }
    }
  }
end

function M.setup(use)
  use {
    'kyazdani42/nvim-tree.lua',
    config = nvim_tree_config,
  }
end

return M
