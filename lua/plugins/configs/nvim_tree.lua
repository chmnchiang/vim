return function()
  require'utils'.noresimap('n', '<leader>t', '<cmd>:NvimTreeToggle<CR>')
  vim.g.nvim_tree_lsp_diagnostics = 1
  vim.g.nvim_tree_icons = {
    lsp = {
      hint = '',
      info = ' ',
      warning = ' ',
      error = ' ',
    }
  }
end
