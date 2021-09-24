return function()
  local noresimap = require'utils'.noresimap

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

  noresimap('i', '<C-Space>', [[compe#complete()]], { expr = true })
  noresimap('i', '<C-e>', [[compe#close('<C-e>')]], { expr = true })
  noresimap('i', '<CR>', [[compe#confirm('<CR>')]], { expr = true })
end
