local icons = require('meteor.icons')

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
      layout_config = { width = 0.8, height = { padding = 2 } },
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
  trouble.setup()
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
    config = telescope_config,
    cmd = 'Telescope',
    keys = function()
      local function with_builtin(f)
        return function()
          local telescope = require('telescope.builtin')
          return f(telescope)
        end
      end
      return {
        {
          '<leader>b',
          with_builtin(function(t)
            t.buffers()
          end),
          desc = 'Telescope search opened buffers',
        },
        {
          '<leader>f',
          with_builtin(function(t)
            t.find_files()
          end),
          desc = 'Telescope search files under CWD',
        },
        {
          '<leader>ss',
          with_builtin(function(t)
            t.live_grep()
          end),
          desc = 'Telescope live search files under CWD with regex',
        },
        {
          '<leader>sr',
          with_builtin(function(t)
            t.resume()
          end),
          desc = 'Resume last Telescope session',
        },
        {
          '<leader>sp',
          with_builtin(function(t)
            t.pickers()
          end),
          desc = 'Telescope search telescope pickers',
        },
        {
          '<leader>sh',
          with_builtin(function(t)
            t.help_tags()
          end),
          desc = 'Telescope search help tags',
        },
      }
    end,
    event = 'VeryLazy',
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    event = 'VeryLazy',
  },
  {
    'nvim-telescope/telescope-symbols.nvim',
    event = 'VeryLazy',
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    opts = {
      auto_close = true,
      use_diagnostic_signs = true,
      signs = {
        error = icons.error,
        warning = icons.warn,
        hint = icons.hint,
        information = icons.info,
        other = icons.question,
      },
    },
  },
}
