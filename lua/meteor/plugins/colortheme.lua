local M = {}

local use_local_repo = true

function M.setup(use)
  use({ '~/.config/nvim/custom-plugins/vim-color-scheme-meteor' })
  use({ 'rktjmp/shipwright.nvim', cmd = { 'Shipwright' } })
  use({ 'rktjmp/lush.nvim', cmd = { 'Lushify' }, after = { 'shipwright.nvim' } })
end

return M
