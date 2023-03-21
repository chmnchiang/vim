vim.g.do_filetype_lua = 1
require('meteor').setup({
  use_lazy_nvim = true,
  dev = true,
  mappings = {
    use_lazy_nvim = true,
    tabline = true,
    telescope = true,
    nvim_tree = true,
    dap = true,
  },
})
