local M = {}

local treesitter_installed_parsers = {
  'bibtex',
  'c',
  'comment',
  'cpp',
  'dart',
  'java',
  'javascript',
  'json',
  'latex',
  'lua',
  'python',
  'rust',
  'typescript',
  'graphql',
  'vim',
}

local treesitter_enabled_filetypes = {
  'bibtex',
  'c',
  'comment',
  'cpp',
  'dart',
  'java',
  'javascript',
  'javascript.jsx',
  'javascriptreact',
  'json',
  'latex',
  'lua',
  'python',
  'rust',
  'typescript',
  'graphql',
  'vim',
  'svelte',
}

local function treesitter_config()
  require('nvim-treesitter.configs').setup({
    ensure_installed = treesitter_installed_parsers,
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
        swap_previous = { ['<Localleader>sh'] = '@parameter.inner' },
      },
    },
    indent = {
      enable = true,
    }
  })
end

local function treesitter_playground_config()
  require('nvim-treesitter.configs').setup({
    playground = {
      enable = false,
    },
  })
end

function M.packages(opt)
  return {
    {
      'nvim-treesitter/nvim-treesitter',
      config = treesitter_config,
      ft = treesitter_enabled_filetypes,
    },
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      config = treesitter_textobjects_config,
      ft = treesitter_enabled_filetypes,
    },
    {
      'nvim-treesitter/playground',
      config = treesitter_playground_config,
      ft = treesitter_enabled_filetypes,
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {},
      ft = treesitter_enabled_filetypes,
    }
  }
end

return M
