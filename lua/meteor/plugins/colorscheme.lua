local M = {}

function M.setup(use)
  use({ '~/.config/nvim/custom-plugins/vim-color-scheme-meteor' })
  use({ 'rktjmp/shipwright.nvim', cmd = { 'Shipwright' } })
  use({ 'rktjmp/lush.nvim', cmd = { 'Lushify' }, after = { 'shipwright.nvim' } })
end

function M.packages(opt)
  local packages = {
    {
      dir = '~/.config/nvim/custom-plugins/vim-color-scheme-meteor',
      lazy = false,
      priority = 1000,
      config = function()
        vim.opt.termguicolors = true
        vim.cmd([[colorscheme meteor-nvim]])
      end,
    },
  }
  if opt and opt.dev then
    vim.list_extend(packages, {
      { 'rktjmp/shipwright.nvim', cmd = { 'Shipwright' } },
      { 'rktjmp/lush.nvim', cmd = { 'Lushify' } },
    })
  end
  return packages
end

return M
