return function()
  vim.cmd[[autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guifg=#282828]]
  vim.cmd[[autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guifg=#383838]]
  vim.g.indent_blankline_buftype_exclude = {'terminal'}
  vim.g.indent_blankline_char_highlight_list = {'IndentGuidesOdd', 'IndentGuidesEven'}
end
