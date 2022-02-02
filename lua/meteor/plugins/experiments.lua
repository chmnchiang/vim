local M = {}

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
end

return M

