local function treesitter_textobjects_config() end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = require('meteor').opt.treesitter.installed_parsers,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<Tab>',
            node_incremental = '<CR>',
            node_decremental = '<S-CR>',
          },
        },
      })
    end,
    event = { 'VeryLazy' },
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    playground = { enable = true },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['ia'] = '@parameter.inner',
              ['aa'] = '@parameter.outer',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ic'] = '@comment.outer',
              ['ac'] = '@comment.outer',
              ['is'] = '@statement.outer',
              ['as'] = '@statement.outer',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']f'] = '@function.outer',
              [']a'] = '@parameter.inner',
            },
            goto_next_end = {
              [']F'] = '@function.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[a'] = '@parameter.inner',
            },
            goto_previous_end = {
              ['[F'] = '@function.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = { ['<Localleader>sl'] = '@parameter.inner' },
            swap_previous = { ['<Localleader>sh'] = '@parameter.inner' },
          },
        },
        indent = {
          enable = false,
        },
      })
    end,
    event = 'VeryLazy',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {},
    event = 'VeryLazy',
  },
}
