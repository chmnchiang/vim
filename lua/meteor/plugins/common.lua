local M = {}

function M.setup(use)
  use {
    'tpope/vim-surround'
  }
  use {
    'scrooloose/nerdcommenter'
  }
  use {
    'ntpeters/vim-better-whitespace'
  }
  use {
    'wellle/targets.vim'
  }
  use {
    'sheerun/vim-polyglot',
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.cmd[[autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guifg=#282828]]
      vim.cmd[[autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guifg=#383838]]
      vim.g.indent_blankline_buftype_exclude = {'terminal', 'help'}
      vim.g.indent_blankline_char_highlight_list = {'IndentGuidesOdd', 'IndentGuidesEven'}
    end,
  }
  use {
    'ojroques/vim-oscyank',
    config = function()
      -- Use OSC52 when + register is used
      vim.cmd[[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif]]
    end
  }
end

return M
