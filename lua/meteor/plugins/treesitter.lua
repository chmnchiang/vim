local M = {}

function M.setup(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'lua', 'rust', 'cpp', 'c', 'java', 'python', 'vim', 'comment',
          'javascript', 'json',
        },
        highlight = {enable = true, additional_vim_regex_highlighting = false},
        playground = {enable = true},
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['ip'] = '@parameter.inner',
              ['ap'] = '@parameter.outer',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      }
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = 'nvim-treesitter/nvim-treesitter',
  }
end

return M
