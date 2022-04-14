local M = {}

local function rust_tools_config()
  require('rust-tools').setup {
    tools = {
      hover_actions = {
        border = require('meteor.plugins.lsp').floating_window_border,
      },
      inlay_hints = {highlight = 'SpecialHint'},
    },
    server = {on_attach = require('meteor.plugins.lsp').lsp_on_attach},
  }
end

function M.setup(use)
  use {
    '~/Documents/Project/google-comments',
    -- after = 'colorscheme',
    config = function()
      local comments = require('google.comments')
      local utils = require('meteor.utils')
      vim.cmd(string.format([[highlight CommentSign guifg=#CCCCCC guibg=%s]],
          utils.get_highlight_color('SignColumn', 'bg')))
      vim.fn.sign_define('METEOR_COMMENTS_ICON',
          {text = ' ', texthl = 'CommentSign'})
      comments.setup {
        sign = 'METEOR_COMMENTS_ICON',
        display = {
          width = function()
            return vim.api.nvim_win_get_width(0) / 3
          end,
        },
        auto_fetch = false,
      }
      utils.noresimap('n', '<Localleader>xc',
          [[<Cmd>lua require('google.comments').toggle_line_comments()<CR>]])
      utils.noresimap('n', '<Leader>xc',
          [[<Cmd>lua require('google.comments').toggle_all_comments()<CR>]])
      utils.noresimap('n', ']xc',
          [[<Cmd>lua require('google.comments').goto_next_comment()<CR>]])
      utils.noresimap('n', '[xc',
          [[<Cmd>lua require('google.comments').goto_prev_comment()<CR>]])
    end,
  }
  use {'simrat39/rust-tools.nvim', config = rust_tools_config, ft = {'rust'}}
  use {
    '~/.config/nvim/custom-plugins/google-runtest',
    after = 'nvim-treesitter',
  }
  use {
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup {}
      vim.api.nvim_set_keymap('n', '<Localleader><Localleader>',
          [[<Cmd>lua require'hop'.hint_words()<Cr>]],
          {noremap = true, silent = true})
      vim.api.nvim_set_keymap('', 's',
          [[<Cmd>lua require'hop'.hint_char2()<Cr>]], {noremap = true, silent = true})
    end,
  }
end

return M

