return function()
  vim.o.completeopt = "menuone,noselect"
  require'compe'.setup({
    enabled = true,
    autocomplete = true,
    min_length = 1,
    preselect = 'enable',
    source = {
      path = true,
      buffer = true,
      calc = true,
      nvim_lsp = true,
      ultisnips = true,
    },
  })
end
