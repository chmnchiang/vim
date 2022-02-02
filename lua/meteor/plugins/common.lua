local M = {}

function M.setup(use)
  use {'tpope/vim-surround', event = 'BufRead'}
  use {'scrooloose/nerdcommenter', event = 'BufRead'}
  use {'ntpeters/vim-better-whitespace', event = 'BufRead'}
  use {'wellle/targets.vim', event = 'BufRead'}
  use {'sheerun/vim-polyglot', event = 'BufRead'}
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.cmd [[autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guifg=#282828]]
      vim.cmd [[autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guifg=#383838]]
      vim.g.indent_blankline_buftype_exclude = {'terminal', 'help'}
      vim.g.indent_blankline_char_highlight_list = {
        'IndentGuidesOdd', 'IndentGuidesEven',
      }
    end,
    event = 'BufRead',
  }
  use {
    'ojroques/vim-oscyank',
    config = function()
      -- Use OSC52 when + register is used
      vim.cmd [[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]
    end,
    event = 'BufRead',
  }
end

return M
