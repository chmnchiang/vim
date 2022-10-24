local M = {}

local function treesitter_config()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'lua',
      'rust',
      'cpp',
      'c',
      'java',
      'python',
      'vim',
      'comment',
      'javascript',
      'json',
    },
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
    playground = { enable = true },
  })
end

local function treesitter_textobjects_config()
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
        swap_prev = { ['<Localleader>sh'] = '@parameter.inner' },
      },
    },
  })
end

local function treesitter_playground_config()
  require('nvim-treesitter.configs').setup({
    playground = {
      enable = false,
    },
  })
end

function M.setup(use)
  use({
    'nvim-treesitter/nvim-treesitter',
    config = treesitter_config,
    event = 'BufRead',
    module = 'nvim-treesitter',
  })
  use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = treesitter_textobjects_config,
    after = 'nvim-treesitter',
  })
  use({
    'nvim-treesitter/playground',
    config = treesitter_playground_config,
    after = 'nvim-treesitter',
  })
end

return M
