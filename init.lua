vim.g.do_filetype_lua = 1
require('meteor').setup({
  mappings = {
    tabline = true,
    telescope = true,
    nvim_tree = true,
    dap = true,
  },
})
