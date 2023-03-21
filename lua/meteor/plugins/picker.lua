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
      layout_config = { vertical = { width = 0.8, height = { padding = 1 } } },
      path_display = { 'truncate' },
    },
    pickers = { buffers = { sort_mru = true } },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown({}),
      },
    },
  }
  -- TODO: Integrate with Trouble.
  telescope.setup(options)
  require('telescope').load_extension('ui-select')
end

local function trouble_config()
  local trouble = require('trouble')
  local icons = require('meteor.icons')
  trouble.setup({
    auto_close = true,
    use_diagnostic_signs = true,
    signs = {
      error = icons.error,
      warning = icons.warn,
      hint = icons.hint,
      information = icons.info,
      other = icons.question,
    },
  })
end

function M.setup(use)
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
    config = telescope_config,
  })
  use({
    'nvim-telescope/telescope-ui-select.nvim',
  })
  use({
    'folke/trouble.nvim',
    config = trouble_config,
    module = 'trouble',
    cmd = { 'Trouble', 'TroubleToggle' },
  })
end

function M.packages(opt)
  return {
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
      config = telescope_config,
      cmd = 'Telescope',
      keys = function()
        local telescope_builtin = require('telescope.builtin')
        return {
          { '<leader>b', telescope_builtin.buffers, desc = 'Telescope search opened buffers' },
          { '<leader>f', telescope_builtin.find_files, desc = 'Telescope search files under CWD' },
          {
            '<leader>ss',
            telescope_builtin.live_grep,
            desc = 'Telescope live search files under CWD with regex',
          },
          { '<leader>sr', telescope_builtin.resume, desc = 'Resume last Telescope session' },
          { '<leader>sp', telescope_builtin.pickers, desc = 'Telescope search telescope pickers' },
          { '<leader>sh', telescope_builtin.help_tags, desc = 'Telescope search help tags' },
        }
      end,
    },
    {
      'nvim-telescope/telescope-ui-select.nvim',
      lazy = false,
    },
    {
      'folke/trouble.nvim',
      config = trouble_config,
      cmd = { 'Trouble', 'TroubleToggle' },
    },
  }
end

return M
