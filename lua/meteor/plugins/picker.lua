local M = {}

local function telescope_config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  local options = {
    defaults = {
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
        },
      },
      layout_strategy = 'vertical',
      layout_config = {vertical = {width = 0.8, height = {padding = 1}}},
      path_display = {'truncate'},
    },
    pickers = {buffers = {sort_mru = true}},
  }
  -- TODO: Integrate with Trouble.
  telescope.setup(options)
end

local function trouble_config()
  local trouble = require('trouble')
  local icons = require('meteor.icons')
  trouble.setup {
    use_diagnostic_signs = true,
    signs = {
      error = icons.error,
      warning = icons.warn,
      hint = icons.hint,
      information = icons.info,
      other = icons.question,
    },
  }
end

function M.setup(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons'},
    config = telescope_config,
    module = 'telescope',
    cmd = {'Telescope'},
  }
  use {
    'folke/trouble.nvim',
    config = trouble_config,
    cmd = {'Trouble', 'TroubleToggle'},
  }
end

return M
