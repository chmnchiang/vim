local M = {}

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
