local M = {}

function M.setup(use)
  use({ 'tpope/vim-surround', event = 'BufRead' })
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        mappings = {
          basic = false,
          extra = false,
        },
      })
      vim.keymap.set('n', '<Localleader>c<Space>', function()
        if vim.api.nvim_get_vvar('count') == 0 then
          return '<Plug>(comment_toggle_linewise_current)'
        else
          return '<Plug>(comment_toggle_linewise_count)'
        end
      end, { expr = true, desc = 'Toggle the comment of current line' })
      vim.keymap.set(
        'x',
        '<Localleader>c<Space>',
        '<Plug>(comment_toggle_linewise_visual)',
        { desc = 'Toggle comment with linewise style' }
      )
      vim.keymap.set('n', '<Localleader>cb', function()
        if vim.api.nvim_get_vvar('count') == 0 then
          return '<Plug>(comment_toggle_blockwise_current)'
        else
          return '<Plug>(comment_toggle_blockwise_count)'
        end
      end, { expr = true, desc = 'Toggle the comment of current line with block style' })
      vim.keymap.set(
        'x',
        '<Localleader>cb',
        '<Plug>(comment_toggle_blockwise_visual)',
        { desc = 'Toggle comment with blockwise style' }
      )
      local api = require('Comment.api')
      vim.keymap.set(
        'n',
        '<Localleader>ca',
        api.locked('insert.linewise.eol'),
        { desc = 'Insert comment at the end of the current line' }
      )
    end,
  })
  use({ 'ntpeters/vim-better-whitespace', event = 'BufRead' })
  use({ 'wellle/targets.vim', event = 'BufRead' })
  use({ 'sheerun/vim-polyglot', event = 'BufRead' })
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g.indent_blankline_buftype_exclude = { 'terminal', 'help' }
      vim.g.indent_blankline_char_highlight_list = {
        'IndentGuidesOdd',
        'IndentGuidesEven',
      }
    end,
    event = 'BufRead',
  })
  use({
    'ojroques/vim-oscyank',
    config = function()
      -- Use OSC52 when + register is used
      vim.cmd(
        [[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]
      )
    end,
    event = 'BufRead',
  })
  use({
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup({
        case_insensitive = false,
      })
    end,
  })
  use({
    'folke/which-key.nvim',
    config = function()
      local which_key = require('which-key')
      which_key.setup({})
      which_key.register({
        c = {
          name = '+Comment actions',
        },
        v = {
          name = '+LSP extra actions',
        },
      }, { prefix = '<Localleader>' })
    end,
  })
end

return M
