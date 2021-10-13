local M = {}

local function telescope_config()
  local telescope = require'telescope'
  local actions = require'telescope.actions'
  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        }
      },
    },
    pickers = {
      buffers = {
        sort_lastused = true,
      }
    }
  }

  local noresimap = require'meteor.utils'.noresimap
  noresimap('n', '<leader>b', '<cmd>Telescope buffers<CR>')
  noresimap('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
  noresimap('n', '<leader>f', '<cmd>Telescope find_files<CR>')
  noresimap('n', '<leader>r', '<cmd>Telescope resume<CR>')
end

function M.setup(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    config = telescope_config,
  }
end

return M
